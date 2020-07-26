import SwiftUI

extension UI {

    
    public struct Button: View {

        public typealias Action = () -> Void
        public enum Style: String, CaseIterable {
            case filled
            case outline
            case flat
            
            case disabled
        }

        public enum Size: String, CaseIterable {
            case small
            case large
        }

        public struct ViewModel {
            public let action: Action
            public let text: String
            public let image: String?
            public let style: Style
            public let size: Size

            public init(action: @escaping Action, text: String, image: String?, style: Style, size: Size) {
                self.action = action
                self.text = text
                self.image = image
                self.style = style
                self.size = size
            }

        }

        let vm: ViewModel

        public init(vm: ViewModel) {
            self.vm = vm
        }

        private var text: some View {
            Text(vm.text)
                .frame(width: nil, height: maxHeight, alignment: .center)
                .font(computeFont)
                .foregroundColor(foregroundColord)
                .lineLimit(1)
        }

        private var uiImage: UIImage? {
            guard let image = vm.image else { return nil }
            return UIImage(named: image)
        }

        var imagePaddingForFullFrame: CGFloat {
            guard let image = uiImage else { return 0 }
            return image.size.width + UI.GenericSize.medium.rawValue
        }

        private var image: some View {
            guard let image = uiImage else { return EmptyView().anyView }
            return Image(uiImage: image)
                .foregroundColor(foregroundColord)
                .anyView
        }

        var uiFont: UIFont {
            switch vm.size {
            case .large:
                return UIFont.systemFont(ofSize: 17, weight: .semibold)
            case .small:
                return UIFont.systemFont(ofSize: 15, weight: .semibold)
            }
        }

        private var computeFont: Font {
            switch vm.size {
            case .large:
                return Font.system(size: 17, weight: .semibold, design: .default)
            case .small:
                return Font.system(size: 15, weight: .semibold, design: .default)
            }
        }

        private var maxHeight: CGFloat {
            switch vm.size {
            case .small:
                return 32
            case .large:
                return 48
            }
        }

        var foregroundColord: Color {
            switch vm.style {
            case .filled, .disabled:
                return Color("primary")
            case .outline, .flat:
                return Color("secondary")
            }
        }

        private var bgColor: Color {
            switch vm.style {
            case .filled:
                return Color("secondary")
            case .outline, .flat:
                return Color(UIColor.clear)
            case .disabled:
                return Color("disabled")
            }
        }

        private var borderColor: Color {
            switch vm.style {
            case .filled, .flat, .disabled:
                return Color(UIColor.clear)
            case .outline:
                return Color("primary")
            }
        }

        private var sidePadding: CGFloat {
            switch vm.size {
            case .large:
                return 16
            case .small:
                return 12
            }
        }

        public var body: some View {

            return SwiftUI.Button(action: {
                self.vm.action()
            }, label: {
                ZStack {
                    bgColor
                    HStack(alignment: .center, spacing: 8) {
                        image
                        text
                    }
                }
            })
            .fixedSize()
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(borderColor, lineWidth: 1))
        }
    }
}
