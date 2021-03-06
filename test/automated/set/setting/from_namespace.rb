require_relative '../../automated_init'

context "Set" do
  context "Setting" do
    context "From Namespace" do
      example = Controls::Subject.example

      settings = Controls::Settings::Namespace.example

      settings.set(example, 'some_namespace')

      test "Assigns data from within the namespace to the corresponding attribute" do
        assert(example.some_setting == 'some value')
      end
    end
  end
end
