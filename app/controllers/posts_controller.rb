class PostsController < ApplicationController
  # GET /posts/new
  # GET /posts/new.xml
  def new
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.find(params[:topic_id])
	@post = @topic.posts.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
	@forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.find(params[:topic_id])
    @post = @topic.posts.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
	@forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.find(params[:topic_id])
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to(forum_topic_path(@forum, @topic), :notice => "Post was successfully created.") }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
	@forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.find(params[:topic_id])
    @post = @topic.posts.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(forum_topic_path(@forum, @topic), :notice => "Post was successfully updated.") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
	@forum = Forum.find(params[:forum_id])
    @post = Post.find(params[:id])
	@topic = @post.topic
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(forum_topic_path(@forum, @topic), :notice => "Post was successfully removed.") }
      format.xml  { head :ok }
    end
  end
end
