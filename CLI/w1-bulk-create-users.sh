#!/usr/bin/env bash
DOMAIN="kelvinmwangi076946gmail.onmicrosoft.com"
CSV="user-inventory.csv"
OUT="initial-passwords.local.csv"
echo "UPN,Password" > "$OUT"

# Pass 1: create users and set attributes
tail -n +2 "$CSV" | tr -d '\r' | while IFS=, read -r alias display given surname dept title loc mgr; do
  upn="$alias@$DOMAIN"
  pw="$(openssl rand -base64 18 | tr -d '=+/')Aa1!"

  if az ad user create \
        --display-name "$display" \
        --user-principal-name "$upn" \
        --mail-nickname "$alias" \
        --password "$pw" \
        --force-change-password-next-sign-in true \
        --output none; then
    echo "$upn,$pw" >> "$OUT"
    az rest --method PATCH \
      --url "https://graph.microsoft.com/v1.0/users/$upn" \
      --headers "Content-Type=application/json" \
      --body "{\"givenName\":\"$given\",\"surname\":\"$surname\",\"department\":\"$dept\",\"jobTitle\":\"$title\",\"usageLocation\":\"$loc\"}" \
      --output none
    echo "Created $upn"
  else
    echo "FAILED $upn" >&2
  fi
done

# Pass 2: managers (every user must exist first)
tail -n +2 "$CSV" | tr -d '\r' | while IFS=, read -r alias display given surname dept title loc mgr; do
  [ -z "$mgr" ] && continue
  mid=$(az ad user show --id "$mgr@$DOMAIN" --query id -o tsv)
  az rest --method PUT \
    --url "https://graph.microsoft.com/v1.0/users/$alias@$DOMAIN/manager/\$ref" \
    --headers "Content-Type=application/json" \
    --body "{\"@odata.id\":\"https://graph.microsoft.com/v1.0/users/$mid\"}" \
    --output none
done