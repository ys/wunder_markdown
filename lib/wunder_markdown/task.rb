module WunderMarkdown
  class Task < Struct.new(:id, :title, :note, :parent_id)
    attr_accessor :children, :client

    def root?
      parent_id.nil?
    end

    def to_markdown
      if root?
        markdown = "## #{title}  \n"
        if note && note != ''
          markdown += "  \n"
          note.chars.each_slice(80) do |slice|
            markdown += "> #{slice.join}\n"
          end
        end
        if children.any?
          markdown += "  \n"
          markdown += children.map(&:to_markdown).join("  \n")
        end
        markdown
      else
        "* #{title} \n"
      end
    end
  end
end
