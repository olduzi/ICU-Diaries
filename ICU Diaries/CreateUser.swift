//
//  CreateUser.swift
//  ICU Diaries
//
//  Created by Kenneth Chou on 11/10/21.
//

import SwiftUI

struct User : Codable {
    var name : String
    var proPic : String
    var dob : Date
}

struct CreateUserView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var rootIsActive : Bool
    
    @State private var newUser = User(name: "", proPic: "", dob: Date()) // initialize differently
    
    var body: some View {
        Color(red: 0.65, green: 0.76, blue: 0.69)
                .ignoresSafeArea() // Ignore just for the color
                .overlay(
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            Text("Create Profile")
                                .font(.largeTitle)
                                .bold()
                            Spacer()
                            NavigationLink(destination: Logout(shouldPopToRootView: self.$rootIsActive)) {
                                Text("Logout")
                                    .foregroundColor(Color.black)
                                    .font(.title2)
                                    .frame(width: 100)
                                    .padding()
                                    .background(Color(red: 0.98, green: 0.49, blue: 0.49))
                                    .clipShape(Capsule())
                                    .offset(y: -10)
                            }
                            .isDetailLink(false)
                        }
                        .padding(.bottom, 10)
                        HStack(alignment: .center) {
                            Text("Name: ")
                                .font(.title2)
                            TextField("Name", text: $newUser.name)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(5.0)
                        }
                        .padding(.bottom, 10)
                        HStack(alignment: .center) {
                            Text("Profile Picture: ")
                                .font(.title2)
//                            ImagePickerView(sourceType: <#T##UIImagePickerController.SourceType#>, onImagePicked: <#T##(UIImage) -> Void#>)
                            TextField("Ken.jpeg", text: $newUser.name)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(5.0)
                            Button("Choose photo", action: {})
                            Spacer()
                        }
                        .padding(.bottom, 10)
                        HStack (alignment: .center) {
                            Text("Birthday: ")
                                .font(.title2)
                            DatePicker("Birthday:", selection: $newUser.dob, displayedComponents: [.date])
                                .labelsHidden()
                                .background(Color.white)
                                .cornerRadius(5.0)
//                            Spacer()
                        }
                        Spacer()
                        HStack {
                            Button(action: {}) {
                                Text("Save")
                                    .foregroundColor(Color.black)
                                    .font(.title2)
                                    .frame(width: 100)
                            }
                            .padding()
                            .background(Color.white)
                            .clipShape(Capsule())
                            Button ("Cancel", action: {self.presentationMode.wrappedValue.dismiss()})
                            .foregroundColor(Color.black)
                            .font(.title2)
                            .frame(width: 100)
                            .padding()
                            .background(Color.white)
                            .clipShape(Capsule())
                        }
                    }
                    .offset(y: -40)
                    .padding()
            )
    }
}

#if DEBUG
struct CreateUser_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserView(rootIsActive: .constant(false))
    }
}
#endif

public struct ImagePickerView: UIViewControllerRepresentable {

    private let sourceType: UIImagePickerController.SourceType
    private let onImagePicked: (UIImage) -> Void
    @Environment(\.presentationMode) private var presentationMode

    public init(sourceType: UIImagePickerController.SourceType, onImagePicked: @escaping (UIImage) -> Void) {
        self.sourceType = sourceType
        self.onImagePicked = onImagePicked
    }

    public func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = self.sourceType
        picker.delegate = context.coordinator
        return picker
    }

    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    public func makeCoordinator() -> Coordinator {
        Coordinator(
            onDismiss: { self.presentationMode.wrappedValue.dismiss() },
            onImagePicked: self.onImagePicked
        )
    }

    final public class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        private let onDismiss: () -> Void
        private let onImagePicked: (UIImage) -> Void

        init(onDismiss: @escaping () -> Void, onImagePicked: @escaping (UIImage) -> Void) {
            self.onDismiss = onDismiss
            self.onImagePicked = onImagePicked
        }

        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                self.onImagePicked(image)
            }
            self.onDismiss()
        }

        public func imagePickerControllerDidCancel(_: UIImagePickerController) {
            self.onDismiss()
        }

    }

}
