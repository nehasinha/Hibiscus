
class PostsController < ApplicationController
  before_filter :authenticate_user!,  :except => [:index, :show]

  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @likes = @post.listLikes
    @dislikes = @post.listDislikes

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @tags = @post.joinTags
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    @post.setTags

    respond_to do |format|
      if @post.save
    #########################################################################################################
    # NEHA SINHA
    # Commented the below line as there is some issue with indextank (that I have not been able to figure
    # out yet). In-spite the error, the record is created successfully in the database.
    #########################################################################################################

        #@post.update_search_index(post_path @post)
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
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
    @post = Post.find(params[:id])
    @post.tempTags = params[:post][:tempTags]
    @post.setTags
    @post.title = params[:post][:title]
    @post.content = params[:post][:content]

    respond_to do |format|
      if @post.save
    #########################################################################################################
    # NEHA SINHA
    # Commented the below line as there is some issue with indextank (that I have not been able to figure
    # out yet). In-spite the error, the database record is updated successfully.
    #########################################################################################################

      #  @post.update_search_index(post_path @post)
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
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
    @post = Post.find(params[:id])
    #########################################################################################################
    # NEHA SINHA
    # Commented the below line as there is some issue with indextank (that I have not been able to figure
    # out yet). In-spite the error, the database record is deleted successfully.
    #########################################################################################################

    #@post.delete_from_search_index(post_path @post)
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url, :notice => 'The post has been deleted') }
      format.xml  { head :ok }
    end
  end
end
