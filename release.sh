#!/usr/bin/env bash
set -e

while getopts v: flag
do
    case "${flag}" in
        v) version=${OPTARG};;
    esac
done

echo $version

./build.sh -c ./config/prod.json

rm -rf ./package
mkdir -p package

echo "{
  \"name\": \"@maplelabs/mpl-rewards\",
  \"version\": \"${version}\",
  \"description\": \"MPL Rewards Artifacts and ABIs\",
  \"author\": \"Maple Labs\",
  \"license\": \"AGPLv3\",
  \"repository\": {
    \"type\": \"git\",
    \"url\": \"https://github.com/maple-labs/mpl-rewards.git\"
  },
  \"bugs\": {
    \"url\": \"https://github.com/maple-labs/mpl-rewards/issues\"
  },
  \"homepage\": \"https://github.com/maple-labs/mpl-rewards\"
}" > package/package.json

mkdir -p package/artifacts
mkdir -p package/abis

cat ./out/dapp.sol.json | jq '.contracts | ."contracts/MplRewardsFactory.sol" | .MplRewardsFactory' > package/artifacts/MplRewardsFactory.json
cat ./out/dapp.sol.json | jq '.contracts | ."contracts/MplRewardsFactory.sol" | .MplRewardsFactory | .abi' > package/abis/MplRewardsFactory.json
cat ./out/dapp.sol.json | jq '.contracts | ."contracts/MplRewards.sol" | .MplRewards' > package/artifacts/MplRewards.json
cat ./out/dapp.sol.json | jq '.contracts | ."contracts/MplRewards.sol" | .MplRewards | .abi' > package/abis/MplRewards.json

npm publish ./package --access public

rm -rf ./package
