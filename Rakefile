# frozen_string_literal: true

require 'rake/testtask'
require_relative 'require_app'
task :default do
  puts `rake -T`
end

desc 'Run unit and integration tests'
Rake::TestTask.new(:spec) do |t|
  t.pattern = 'spec/tests/**/*_spec.rb'
  t.warning = false
end


desc 'Keep rerunning unit/integration tests upon changes'
task :respec do
  sh "rerun -c 'rake spec' --ignore 'coverage/*' --ignore 'repostore/*'"
end

desc 'Run the webserver and application and restart if code changes'
task :rerun do
  sh "rerun -c --ignore 'coverage/*' --ignore 'repostore/*' -- bundle exec puma"
end

desc 'Run web app in default (dev) mode'
task run: ['run:default']

namespace :run do
  desc 'Run API in dev mode'
  task :default do
    sh 'rerun -c "bundle exec puma -p 9090"'
  end

  desc 'Run API in test mode'
  task :test do
    sh 'RACK_ENV=test bundle exec puma -p 9090'
  end
end


desc 'Generates a 64-byte secret for Rack::Session'
task :new_session_secret do
  require 'base64'
  require 'securerandom' # Corrected capitalization here
  secret = SecureRandom.random_bytes(64).then { Base64.urlsafe_encode64(_1) }
  puts "SESSION_SECRET: #{secret}"
end

namespace :db do
  task :config do # rubocop:disable Rake/Desc
    require 'sequel'
    require_relative 'config/environment' # load config info
    require_relative 'spec/helpers/database_helper'

    def app = RoutePlanner::App # rubocop:disable Rake/MethodDefinitionInTask
  end

  desc 'Run migration'
  task migrate: :config do
    Sequel.extension :migration
    puts "Migrating #{app.environment} database to latest"
    Sequel::Migrator.run(app.db, 'db/migrations')
  end

  desc 'Wipe records from all tables'
  task wipe: :config do
    if app.environment == :production
      puts 'Do not damage production database!'
      return
    end

    require_app(%w[domain infrastructure])
    DatabaseHelper.wipe_database
  end

  desc 'Delete dev or test database file (set correct RACK_ENV)'
  task drop: :config do
    if app.environment == :production
      puts 'Do not damage production database!'
      return
    end

    FileUtils.rm(RoutePlanner::App.config.DB_FILENAME)
    puts "Deleted #{RoutePlanner::App.config.DB_FILENAME}"
  end
end

namespace :repos do
  task :config do # rubocop:disable Rake/Desc
    require_relative 'config/environment' # load config info
    def app = CodePraise::App # rubocop:disable Rake/MethodDefinitionInTask
    @repo_dirs = Dir.glob("#{app.config.REPOSTORE_PATH}/*/")
  end

  desc 'Create directory for repo store'
  task :create => :config do
    puts `mkdir #{app.config.REPOSTORE_PATH}`
  end

  desc 'Delete cloned repos in repo store'
  task :wipe => :config do
    puts 'No git repositories found in repostore' if @repo_dirs.empty?

    sh "rm -rf #{app.config.REPOSTORE_PATH}/*/" do |ok, _|
      puts(ok ? "#{@repo_dirs.count} repos deleted" : 'Could not delete repos')
    end
  end

  desc 'List cloned repos in repo store'
  task :list => :config do
    if @repo_dirs.empty?
      puts 'No git repositories found in repostore'
    else
      puts @repo_dirs.join("\n")
    end
  end
end

desc 'Run application console'
task :console do
  sh 'pry -r ./load_all'
end

namespace :vcr do
  desc 'delete cassette fixtures'
  task :wipe do
    sh 'rm spec/fixtures/cassettes/*.yml' do |ok, _|
      puts(ok ? 'Cassettes deleted' : 'No cassettes found')
    end
  end
end

namespace :quality do
  only_app = 'config/ app/'

  desc 'run all static-analysis quality checks'
  task all: %i[rubocop reek flog]

  desc 'code style linter'
  task :rubocop do
    sh 'rubocop'
  end

  desc 'code smell detector'
  task :reek do
    sh 'reek'
  end

  desc 'complexiy analysis'
  task :flog do
    sh "flog -m #{only_app}"
  end
end
