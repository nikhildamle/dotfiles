export ANDROID_SDK="$HOME/software/android-sdk"

# Add tools and platform-tools to path.
if [ -d "$ANDROID_SDK" ]; then
	# Add tools and platform-tools to path
	export PATH="$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:$PATH"

    # Add latest build-tools to path.
	if command -V ruby > /dev/null; then
		eval "$(ruby $DOTFILES_DIR/android/build-tools-path.rb)"
	else
		echo 'Ruby Not Installed: Android build tools could not be added to PATH, because script that does this depends on Ruby.'
	fi
fi
