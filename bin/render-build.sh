set -o errexit
set -o xtrace

echo "=== RENDER BUILD SCRIPT START ==="
bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
echo "=== RUN MIGRATIONS ==="
bundle exec rails db:migrate
echo "=== MIGRATIONS DONE ==="