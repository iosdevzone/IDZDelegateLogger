REPO=IDZPodspecs
NAME=IDZDelegateLogger

# push tags to GitHub
push_tags:
	git push origin --tags

# Push pod to private spec repository
push_pod:
	pod repo push ${REPO} ${NAME}.podspec
