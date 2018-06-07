# frozen_string_literal: true

class DiscussionsController < ApplicationController
  before_action :set_note, only: %i[create_message fetch]
  respond_to :js, only: %i[create_message fetch]

  def create_message
    @note.discussions.create(user: @user, content: params[:content])
    # @note.reload
  end

  def fetch; end

  private

  def set_note
    @note = Note.find(params[:note_id])
    @discussions = @note.discussions
    @user = current_user
  end
end
