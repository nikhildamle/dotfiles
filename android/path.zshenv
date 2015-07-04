export ANDROID_SDK="$HOME/software/android-sdk"

# Add tools and platform-tools to path
export PATH="$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:$PATH"

# Add latest build-tools to path. Requires ruby to be installed.
if command -V ruby > /dev/null; then
	eval "$(ruby $DOTFILES_DIR/android/build-tools-path.rb)"
fi
