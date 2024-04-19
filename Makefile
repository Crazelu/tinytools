buildWeb:
	flutter build web -t lib/main.prod.dart --web-renderer html

runCodeGen:
	dart run build_runner build --delete-conflicting-outputs