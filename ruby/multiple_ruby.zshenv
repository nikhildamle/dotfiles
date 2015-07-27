if [ -f /usr/local/share/chruby/chruby.sh ] ; then
  source /usr/local/share/chruby/chruby.sh
elif type ruby > /dev/null; then
  export GEM_HOME=$(ruby -e 'print Gem.user_dir')
  export PATH="$GEM_HOME/bin:$PATH"
fi
