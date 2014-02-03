class TabsController < ApplicationController
  before_filter :load_tab, only: [:show, :edit, :update]
  def new
    @tab = Tab.new(instrument: 'guitar')
  end
  
  def create
    @tab = Tab.new(params[:tab])
    if @tab.save
      redirect_to tab_path(@tab)
    else
      flash[:error] = 'Curses! Curses? Yah. Something went wrong'
      render :new
    end
  end
  
  def edit
    render :new
  end
  
  def update
    if @tab.update_attributes(params[:tab])
      redirect_to tab_path(@tab)
    else
      flash[:error] = 'Curses! Curses? Yah. Something went wrong'
      render :edit
    end
    
  end
  
  def show
  end

protected
  def load_tab
    @tab = Tab.find(params[:id])
  end
end