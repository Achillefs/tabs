class TabsController < ApplicationController
  def new
    @tab = Tab.new
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
end