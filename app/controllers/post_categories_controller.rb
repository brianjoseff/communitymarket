class PostCategoriesController < ApplicationController
  #search implemented with Ransack gem
  # GET /post_categories
  # GET /post_categories.json
  def index
    @post_categories = PostCategory.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @post_categories.tokens(params[:t]) }
    end
  end

  # GET /post_categories/1
  # GET /post_categories/1.json
  def show
    @post_category = PostCategory.find(params[:id])
    unless @post_category.posts.empty?
		  @posts = @post_category.posts.select{|x| x.active?}.sort { |x,y| y.created_at <=> x.created_at }
		  @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(50)
		end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post_category }
    end
  end

  # GET /post_categories/new
  # GET /post_categories/new.json
  def new
    @post_category = PostCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post_category }
    end
  end

  # GET /post_categories/1/edit
  def edit
    @post_category = PostCategory.find(params[:id])
  end

  # POST /post_categories
  # POST /post_categories.json
  def create
    @post_category = PostCategory.new(params[:post_category])

    respond_to do |format|
      if @post_category.save
        format.html { redirect_to post_categories_path, notice: 'Post category was successfully created.' }
        format.json { render json: post_categories_path, status: :created, location: @post_category }
      else
        format.html { render action: "new" }
        format.json { render json: @post_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /post_categories/1
  # PUT /post_categories/1.json
  def update
    @post_category = PostCategory.find(params[:id])

    respond_to do |format|
      if @post_category.update_attributes(params[:post_category])
        format.html { redirect_to @post_category, notice: 'post_category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_categories/1
  # DELETE /post_categories/1.json
  def destroy
    @post_category = PostCategory.find(params[:id])
    @post_category.destroy

    respond_to do |format|
      format.html { redirect_to post_categories_url }
      format.json { head :no_content }
    end
  end
end