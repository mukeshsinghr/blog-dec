class PostsController < ApplicationController
  before_filter :set_post, only: [:edit, :update, :destroy]
  around_action :audit_logs, only: [:update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  def all_posts

  end

  # GET /posts/1
  # GET /posts/1.json
  def show

    respond_to do |format|
      begin
          result = {:code => 0, :body => "" }
          @post = Post.find(params[:id])
        if @post
          result = { :code => 200, :body => {:post => @post, :comments=> @post.comments} }
        end
      rescue ActiveRecord::RecordNotFound => e
        Rails.logger.error "e.message"
        result[:code] = 99
        result[:body] = "Post not available with post_id=#{params[:id]}"
      end
      format.html {  }
      format.json { render :json => result}
      format.xml { render :xml => result}
    end

  end

  # GET /posts/new
  def new
    @post = Post.new
    puts "post contents :#{@post.inspect}"
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    puts "post contents :#{@post.inspect}"
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      puts "Setting a post for post_id=#{params[:id]}"
      @post = Post.find(params[:id])
    end

    def audit_logs
      Rails.logger.info "AUDIT LOG: At  #{Time.now}, Before Post id=#{@post.id} is updated"
      yield
      Rails.logger.info "AUDIT LOG: At  #{Time.now}, After Post id=#{@post.id} is updated"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      puts "data from the client:#{params}"
      params.require(:post).permit(:title, :body)
    end
end
