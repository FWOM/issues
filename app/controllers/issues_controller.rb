class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  # GET /issues
  # GET /issues.json
  def index
    @title = 'Issues'
    @issues = Issue
    @issues = Issue.order(params[:sort]) if params[:sort]
    @issues = @issues.all
    @issues = Issue.find(:all, :conditions => ['title LIKE ?', "%#{params[:title]}%"]) if params[:title]
    respond_to do |format|
      format.html #index.html.erb
      format.json { render json: @issues }
      format.xml { render xml: @issues }
      format.rss #index.rss.builder
      format.csv #index.csv.erb
    end
  end

  # GET /issues/1
  # GET /issues/1.json
  # GET /issues/new
  def new
    @issue = Issue.new
    unless params[:project_id].nil?
      @project = Project.find(params[:project_id])
      @issue.project = @project
    end
  end

  # GET /issues/1/edit
  def edit
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = Issue.new(issue_params)
    @project = Project.find(params[:project_id]) unless params[:project_id].nil?
    respond_to do |format|
      if @issue.save
        IssueMailer.issue_created(@issue).deliver!
        format.html { redirect_to @issue, notice: 'Issue was successfully created.' }
        format.json { render action: 'show', status: :created, location: @issue }
      else
        format.html { render action: 'new' }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issues/1
  # PATCH/PUT /issues/1.json
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to @issue, notice: 'Issue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to issues_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def issue_params
      params.require(:issue).permit(:title, :description, :no_followers, :project_id, :tags)
    end
end
