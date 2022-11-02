#! /usr/bin/zsh

if [ $# -lt 1 ]
then
	>&2 echo "Usage: $0 <path-to-json>"
	exit 64
fi

IFS=$"\n" 

cat $1 | jq -c 'to_entries[]' |
while read -r c;
do
    key=$(echo "$c" | jq -r '.key')
    value=$(echo "$c" | jq -r '.value.value')
    echo aws ssm put-parameter --name "$key" --value "$value" --type String --overwrite
    aws ssm put-parameter --name "$key" --value "$value" --type String --overwrite | cat
done

