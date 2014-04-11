class IssueMailer < ActionMailer::Base
  default from: "felipewom@gmail.com"

  def issue_created(issue)
    @issue = issue
    mail subject: "New issue was created #{Time.now.strftime("%d, %b %Y - %H:%M:%S")}", to: "felipewom@gmail.com"
  end
end
