#!/bin/bash
# Generates and pushes changelog files on all branches
# Running this without arguments will commit but not push the changelogs

cd ../../sealab13

original_branch="$(git rev-parse --abbrev-ref HEAD)"

for i in dev master hotfix; do
	echo "Generating changelogs for branch $i..."
	git checkout -q $i
	git reset -q
	python ../automation-tools/changelogs/changelog.py $i
	git add html/changelogs

	# check if anything got staged
	if [[ -n $(git diff --cached) ]]; then
		git commit -q -m "Automatic changelog generation"

		# push the commit immediately
		if [[ "$1" ]]; then
			echo "Pushing changelogs for branch $i..."
			git push
		fi
	else
		echo "No new changelogs on $i"
	fi
done

git checkout -q $original_branch
echo "Changelogs generated for all branches"
if [[ -z "$1" ]]; then
	echo "You may now push the changelogs"
fi
