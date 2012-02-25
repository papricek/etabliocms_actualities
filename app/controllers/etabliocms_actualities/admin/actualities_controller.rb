module EtabliocmsActualities
  module Admin
    class ActualitiesController < EtabliocmsCore::Admin::BaseController

      def index
        @actualities = Actuality.order(params[:order] || "created_at DESC").page(params[:page])
      end

      def new
        @actuality = Actuality.new
      end

      def create
        @actuality = Actuality.new(params[:actuality])
        if @actuality.save
          flash[:notice] = t('actuality.created')
          redirect_to :action => 'index'
        else
          render :action => 'new'
        end
      end

      def edit
        @actuality = Actuality.find(params[:id])
      end

      def update
        @actuality = Actuality.find(params[:id])
        if @actuality.update_attributes(params[:actuality])
          flash[:notice] = t('actuality.updated')
          redirect_to :action => 'index'
        else
          render :action => 'edit'
        end
      end

      def destroy
        Actuality.find(params[:id]).destroy
        flash[:notice] = t('actuality.destroyed')
        redirect_to :action => 'index'
      end

    end
  end
end
