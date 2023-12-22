import SwiftUI
import MapKit

struct Profiletest {
    var firstName: String
    var lastName: String
    var city: String
}

struct BasicEditableProfileView: View {
    @State var profiletest: Profiletest
    @State var mode: EditMode = .inactive
    @Namespace private var namespace


    var body: some View {
        NavigationView {
            Group {
                if mode.isEditing {
                    editFormView()
                } else {
                    formView()
                }
            }
            .navigationTitle("Profile")
            .navigationBarItems(trailing: EditButton())
            .environment(\.editMode, self.$mode)
        }
    }

    fileprivate func formView() -> some View {
        return Form{

            Section(header: Text("My info")) {
                HStack {
                    Text("First name:")
                    Spacer()
                    Text(profiletest.firstName).foregroundColor(.secondary)
                }


                HStack {
                    Text("Last name:")
                    Spacer()
                    Text(profiletest.lastName).foregroundColor(.secondary)
                }

                HStack {
                    Text("City:")
                    Spacer()
                    Text(profiletest.city).foregroundColor(.secondary)
                }
            }

        }
    }

    fileprivate func editFormView() -> some View {
        return Form{
            Section(header: Text("First name")) {
                TextField("first name",text: $profiletest.firstName)

            }
            Section(header: Text("Last name")) {
                TextField("Last name",text: $profiletest.lastName)
            }
            Section(header: Text("City")) {
                //TextField("City",text: $profiletets.city)
            }

        }
    }
}

struct SwiftUIBasics_Previews: PreviewProvider {
    static var previews: some View {
        BasicEditableProfileView(profiletest: Profiletest(firstName: "Tim", lastName: "Cook", city: "Cupertino"))
    }
}
