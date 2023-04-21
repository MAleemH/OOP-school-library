require 'spec_helper'

describe Student do
    before :each do
        @student = Student.new 23, "Muhammad Asif", true
    end
    context "#new" do
        it "takes three parameters and return a student object" do
            expect(@student).to be_an_instance_of Student
        end
    end
end
