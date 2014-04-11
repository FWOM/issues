xml.instruct! :xml, version: '1.0'
xml.rss version: '2.0' do #<rss version="2.0">
  xml.channel do
    xml.title "Issues"
    xml.description "Latest issues"
    xml.link issues_url

    @issues.each do |issue|
      xml.item do
        xml.title issue.title
        xml.description issue.description
        xml.pubDate issue.created_at.to_s(:rfc822)
      end
    end
  end
end
