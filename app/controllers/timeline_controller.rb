class TimelineController < ApplicationController
  def index
    @title = 'Linha do Tempo'
    @timelines = Timeline.all
  end
end
