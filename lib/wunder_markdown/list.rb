module WunderMarkdown
  class List < Struct.new(:id, :name)
    attr_accessor :tasks, :client

    def to_markdown
      markdown = "# #{name}  \n  \n"
      if tasks
        markdown += tasks.map(&:to_markdown).join("  \n")
      end
      markdown
    end
  end
end
