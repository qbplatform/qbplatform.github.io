deploy:
	git checkout source
	git add -A
	git commit -m "update source"
	git checkout master
	git pull
	git merge source
	git push origin master
	git checkout source
	echo "deploy succeed"
