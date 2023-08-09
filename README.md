update config.mk for the collection you want to build

run make collection -e mode=staging # to run tiktoken or deterministic for TDD. Less deterministic on final build and A/B after that

run yarn test to run integration tests

```sh
hooks/post-save
```

run make

now run it again with extra filters

and so on until result as desired

finally put finishing touches on images etc.

launch social media campaign

run 

make -e flag=up

you can run make src/content/drafts/%.mdx for debugging

run make deploy:staging
run make deploy production<-staging
this will run netlify deploy and git push
trigger workflow for sync

you can print the final collection using make final
done and on to the next thing
endless scrolling

yarn build

looks good?
git push

Create a file named `staging.json` with a property `deploy_url` set to the value of the `URL` you want to track.

With that in place, run this command

```
make
```

This will update `staging.json` and create `production.json`. Content fetched from the original `URL` is passed through `panflute` which in turn calls generative AI functions.

since staging was updated, you can can this command again to get
now you can rerun this command and you should have
rolling deployments logged with netlify
and versioned with git
and backed up with restic
and caollaborate with calendar
and all therest

You can create an index or abstract using

```
make index abstract appendix
```

You should deploy to production with

```
make prod
```

The output is useful for social media campaigns

```sh
make clean # to start fresh
make -e DEPLOY_URL=https://philip.greenspun.com/seia
make staging.json # Now deploy URL is your own and MDX is filled in with prompts
make production.json # release a version with the prompts filled in
```