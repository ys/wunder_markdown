require 'wunder_markdown/client'
require 'wunder_markdown/auth'
require 'optparse'

module WunderMarkdown
  class CLI
    attr_reader :options, :args, :command

    def self.run(args)
      new.call(args)
    # rescue StandardError
    #   $stderr.puts 'Woops, Something went wrong.'
    #   exit 1
    end

    def call(args)
      args, options = preparse(args)
      command = args.shift
      public_send(command, args, options)
    end

    def preparse(args)
      options = OpenStruct.new
      opt_parse = OptionParser.new do |opts|
        opts.banner = "Usage: wundermarkdown <command> <args> [options]"
        opts.on("-e EMAIL", "--email EMAIL", "Email address") do |email|
          options.email = email
        end
      end
      opt_parse.parse!(args)
      unless args.count >= 1
        $stderr.puts opt_parse
        exit 1
      end
      [args, options]
    end

    def config(args, options)
      $stdout.puts 'Wunderlist Credentials: We will not store your password'
      email = options[:email]
      if ! email
        $stdout.puts 'email:'
        email = $stdin.gets.chomp
      end
      $stdout.puts 'Password:'
      system 'stty -echo'
      password = $stdin.gets.chomp
      system 'stty echo'
      WunderMarkdown::Auth.new.save(*client.login(email, password))
    end

    def dump(args, options)
      list_name = args.shift
      unless list_name
        $stderr.puts 'Usage: wundermarkdown dump <list_name>'
        exit 1
      end
      list = client.list(list_name)
      list.tasks = group_tasks(client.tasks(list))
      $stdout.puts list.to_markdown
    end

    def group_tasks(tasks)
      root_tasks = tasks.select { |task| task.root? }
      root_tasks.map do |task|
        task.children = tasks.select { |t| t.parent_id == task.id }
        task
      end
    end

    def client
      @client ||= WunderMarkdown::Client.new(token)
    end

    def token
      @token ||= WunderMarkdown::Auth.new.get
    end
  end
end
