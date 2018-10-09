## Automated changelog generator

Generates YAML changelog files based on pull request descriptions.

#### Usage
In your pull requests, add a changelog by writing
```
:cl: author
rscadd: Added some new stuff
rscdel: Removed some old stuff
bugfix: Squash squosh buggos
tweak: 
...
/:cl:
```
All lines between the `:cl:` tags are parsed as changelog entries. A list of valid changelog entry types can be found at the top of `changelog.py`.

#### Script usage

Set up the required environment variables. `AUTOCL_REPO` should be formatted as `username/reponame`. If you expect to be processing a large amount of PRs each time you run the script, you might want to supply your github username along with a personal access token in `AUTOCL_GITHUB_USER` and `AUTOCL_GITHUB_PAT` to avoid API rate limiting. If you want the changelog posted to Discord, make sure to set `AUTOCL_DISCORD_ID` and `AUTOCL_DISCORD_TOKEN` to the appropriate values for your changelog channel webhook.

You probably want to go in and change where the YAML files are saved. I wrote this tool for a very specific project and that's reflected in the file code. If you don't want to save to file, you can just comment it out of `generate_changelogs` and you won't have to worry about it.

Run the script with the branch you want to generate changelogs for as the argument, e.g. `python changelog.py master`. See `generate_cls.sh` for example usage.

#### How it works
When the script is run, it'll fetch all pull requests that were merged into the chosen branch. The script then loops through and parses the pull request descriptions and generates a YAML changelog file for each new pull request since the last time the script was ran. Changelogs are also posted to Discord but you can just comment it out if you don't want that.