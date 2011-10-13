class TopicsController < ApplicationController

  def show
    @topic = Topic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.xml
  def new
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.find(params[:id])
  end

  # POST /topics
  # POST /topics.xml
  def create
	@forum = Forum.find(params[:forum_id])
    @topic = Topic.new(params[:topic])

    respond_to do |format|
      if @topic.save
        format.html { redirect_to(@forum, :notice => "Topic '#{@topic.title}' was successfully created with id #{@topic.forum_id}.") }
        format.xml  { render :xml => @topic.forum, :status => :created, :location => @topic }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.xml
  def update
	@forum = Forum.find(params[:forum_id])
	@topic = @forum.topics.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to(@topic.forum, :notice => "Topic '#{@topic.title}' was successfully updated.") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.xml
  def destroy
	@forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.find(params[:id])
	@temp_forum = @topic.forum
    @topic.destroy
	

    respond_to do |format|
      format.html { redirect_to(@temp_forum, :notice => "Topic '#{@topic.title}' was successfully removed.") }
      format.xml  { head :ok }
    end
  end
end
