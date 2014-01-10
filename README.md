# WunderMarkdown

**Dump your wunderlists to markdown**

## Installation

    $ gem install wunder_markdown
    
## Configuration
  
    $ wundermarkdown config -e <email>

It will prompt you for your wunderlist password to retrieve a token.  
-e option is optionnal, your email will be asked if not given.  

**It does not store your password**  

It uses netrc internally to store the user token.  
See `~/.netrc` file after configuration.  

## Usage

    $ wundermarkdown dump <list_name>

It will dump a markdown formatted version of your wunderlist list.  
The output will be directed to standard output.  
It can be redirected to a file as you know.  

## Contributing

1. Fork it ( http://github.com/ys/wunder_markdown/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
