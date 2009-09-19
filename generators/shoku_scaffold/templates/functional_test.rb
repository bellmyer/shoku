require 'test_helper'

<% casuals = table_name.gsub(/_/, ' ') %>
<% casual  = file_name.gsub(/_/, ' ') %>

class <%= controller_class_name %>ControllerTest < ActionController::TestCase
  context "getting the list of <%= casuals %>" do
    setup do
      get :index
    end

    should_respond_with :success
    should_render_template :index
    should_not_set_the_flash
  end

  context "getting index of <%= casuals %> with assigned values" do
    setup do
      @<%= file_name %> = Factory :<%= file_name %>
      get :index
    end
    
    should_assign_to :<%= table_name %>, :equals => '[@<%= file_name %>]'
  end

  context "showing a <%= casual %>" do
    setup do
      @<%= file_name %> = Factory :<%= file_name %>
      get :show, :id => @<%= file_name %>.id
    end
    
    should_respond_with :success
    should_render_template :show
    should_not_set_the_flash
    should_assign_to :<%=file_name %>, :equals => '@<%= file_name %>'
  end

  context "showing the new <%= casual %> form" do
    setup do
      @<%= file_name %> = <%= class_name %>.new
      <%= class_name %>.stubs(:new).returns(@<%= file_name %>)
      
      get :new
    end
    
    should_respond_with :success
    should_render_template :new
    should_not_set_the_flash
    should_assign_to :<%= file_name %>, :equals => '@<%= file_name %>'
  end

  context "saving a new <%= casual %> successfully" do
    setup do
      @<%= file_name %> = <%= class_name %>.new
      <%= class_name %>.stubs(:new).returns(@<%= file_name %>)
      
      post :create, :<%= file_name %> => Factory.build(:<%= file_name %>).attributes
    end
    
    should_redirect_to '<%= table_name %>_url'
    should_set_the_flash_to "This <%= casual %> was saved successfully."
    should_assign_to :<%= file_name %>, :equals => '@<%= file_name %>'
  end

  context "saving a new <%= casual %> unsuccessfully" do
    setup do
      @<%= file_name %> = <%= class_name %>.new
      <%= class_name %>.stubs(:new).returns(@<%= file_name %>)
      <%= class_name %>.any_instance.stubs(:save).returns(false)
      
      post :create, :<%= file_name %> => Factory.build(:<%= file_name %>).attributes
    end
    
    should_respond_with :success
    should_render_template :new
    should_not_set_the_flash
    should_assign_to :<%= file_name %>, :equals => '@<%= file_name %>'
  end

  context "editing a <%= casual %>" do
    setup do
      @<%= file_name %> = Factory :<%= file_name %>
      get :edit, :id => @<%= file_name %>.id
    end
    
    should_respond_with :success
    should_render_template :edit
    should_not_set_the_flash
    should_assign_to :<%= file_name %>, :equals => '@<%= file_name %>'
  end
  
  context "updating a <%= casual %> successfully" do
    setup do
      @<%= file_name %> = Factory :<%= file_name %>
      put :update, :id => @<%= file_name %>.id, :<%= file_name %> => {}
    end
    
    should_redirect_to '<%= table_name %>_url'
    should_set_the_flash_to "This <%= casual %> was updated successfully."
    should_assign_to :<%= file_name %>, :equals => '@<%= file_name %>'
  end
  
  context "updating a <%= casual %> unsuccessfully" do
    setup do
      @<%= file_name %> = Factory :<%= file_name %>
      <%= class_name %>.any_instance.stubs(:save).returns(false)
      
      put :update, :id => @<%= file_name %>.id, :<%= file_name %> => {}
    end
    
    should_respond_with :success
    should_render_template :edit
    should_not_set_the_flash
    should_assign_to :<%= file_name %>, :equals => '@<%= file_name %>'
  end
  
  context "deleting a <%= casual %>" do
    setup do
      @<%= file_name %> = Factory :<%= file_name %>
      delete :destroy, :id => @<%= file_name %>.id
    end
    
    should_redirect_to '<%= table_name %>_url'
    should_not_set_the_flash
    should_assign_to :<%= file_name %>, :equals => '@<%= file_name %>'
  end
  
  context "deleting a <%= casual %> and verifying" do
    should "confirm a <%= casual %> has been deleted" do
      @<%= file_name %> = Factory :<%= file_name %>
      assert_difference '<%= class_name %>.count', -1 do
        delete :destroy, :id => @<%= file_name %>.id
      end
    end
  end
end
