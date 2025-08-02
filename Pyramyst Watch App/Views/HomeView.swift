import SwiftUI
import WatchKit

struct HomeView: View {
    
    @StateObject private var router = MainFlowRouter()
    
    @Namespace private var namespace
    
    init() {
        print("HomeView initialized")
        
#if DEBUG
        print("Running in DEBUG build")
#elseif TESTING
        print("Running in TESTING build")
#endif
    }
    
    var body: some View {
        NavigationStack(path: $router.navPaths) {
            mainView
                .navigationDestination(for: MainFlow.self) { destination in
                    destination.destinationView
                        .navigationTitle(destination.title)
                        .toolbarRole(.automatic)
                }
        }
        .environmentObject(router)
    }
    
    private var mainView: some View {
        GeometryReader { geometry in
            ZStack {
                Image("desertFrame")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width + 8, height: geometry.size.height + 8)
                    .offset(y: -geometry.size.height * 0.02)
                    .clipped()
                
                VStack(spacing: 0) {
                    
                    ZStack() {
                        Image("logoPyramyst")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: logoHeight(for: geometry))
                            .padding(.bottom, geometry.size.height * 0.11)
                        
                        Button(action: {
                            playButtonTapped()
                        }) {
                            Image("buttonPlay")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: playButtonHeight(for: geometry))
                                .padding(.top, geometry.size.height * 0.2)
                        }
                        .buttonStyle(.plain)
                    }
                    .offset(y: geometry.size.height * 0.2)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .frame(height: geometry.size.height * 0.6)
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            collectionButtonTapped()
                        }) {
                            Image("collectionButton")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: buttonSize(for: geometry),
                                       height: buttonSize(for: geometry))
                                .padding(.top, geometry.size.height * 0.08)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, horizontalPadding(for: geometry))
                    .padding(.trailing,geometry.size.height * 0.05)
                    .frame(height: geometry.size.height * 0.2)
                    .offset(y: geometry.size.height * 0.09)
                    
                    Spacer()
                        .frame(height: geometry.size.height * 0.2)
                }
            }
            .background(Color(uiColor: UIColor(named: "mainMenuColor") ?? .yellow))
        }
        .ignoresSafeArea(.all)
    }
    
    private func buttonSize(for geometry: GeometryProxy) -> CGFloat {
        min(geometry.size.width * 0.18, 35) // Max 35, min 18% dari width
    }
    
    private func horizontalPadding(for geometry: GeometryProxy) -> CGFloat {
        geometry.size.width * 0.05 // 5% dari width
    }
    
    private func topPadding(for geometry: GeometryProxy) -> CGFloat {
        geometry.size.height * 0.21 // 5% dari height
    }
    
    private func centerSpacing(for geometry: GeometryProxy) -> CGFloat {
        min(geometry.size.height * 0.1, 20) // Max 20, min 10% dari height
    }
    
    private func logoHeight(for geometry: GeometryProxy) -> CGFloat {
        geometry.size.height * 0.72 // 25% dari height
    }
    
    private func playButtonHeight(for geometry: GeometryProxy) -> CGFloat {
        geometry.size.height * 0.2 // 20% dari height
    }
    
    private func playButtonTapped() {
        WKInterfaceDevice.current().play(.click)
        router.navigateTo(.storyView)
    }
    
    private func collectionButtonTapped() {
        
        WKInterfaceDevice.current().play(.click)
        router.navigateTo(.inventoryView)
    }
}

struct NoTapAnimationStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .contentShape(Rectangle())
            .onTapGesture(perform: configuration.trigger)
    }
}
