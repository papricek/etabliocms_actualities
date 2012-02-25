module EtabliocmsActualities
  module Admin
    class CategoriesController < EtabliocmsCore::Admin::BaseController

      def new
        @category = Category.new
      end

      def create
        @category = Category.new(params[:category])
        if @category.save
          flash[:notice] = t('category.created')
          redirect_to :action => 'index'
        else
          render :action => 'new'
        end
      end

      def edit
        @category = Category.find(params[:id])
      end

      def update
        @category = Category.find(params[:id])
        if @category.update_attributes(params[:category])
          flash[:notice] = t('category.updated')
          redirect_to :action => 'index'
        else
          render :action => 'edit'
        end
      end

      def destroy
        Category.find(params[:id]).destroy
        flash[:notice] = t('category.destroyed')
        redirect_to :action => 'index'
      end

      def move
        @category = Category.find(params[:id])
        if ["move_lower", "move_higher", "move_to_top", "move_to_bottom"].include?(params[:method])
          @category.send(params[:method])
          flash[:notice] = t('category.moved')
        else
          flash[:notice] = t('category.not_moved')
        end
        redirect_to :action => 'index'
      end

    end
  end
end