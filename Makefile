REPO=IDZPodspecs
NAME=IDZDelegateLogger

# push tags to GitHub
push_tags:
	git push origin --tags

# Lint the podspec
lint_pod:
	pod spec lint --verbose IDZDelegateLogger.podspec --sources=https://github.com/iosdevzone/IDZPodspecs.git

# Push pod to private spec repository
push_pod:
	pod repo push ${REPO} ${NAME}.podspec
