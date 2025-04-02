//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                navigations
                
                if viewModel.favoriteCoins.isEmpty {
                    Text("No assets added yet")
                        .foregroundColor(Color(.darkPrimary))
                        .font(.system(size: 16, weight: .bold))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(.backgroundPrimary))
                        .accessibilityIdentifier("NoAssetsAdded")
                } else {
                    List {
                        Text("Last Updated: \(viewModel.latestUpdateDateFormatted)")
                            .foregroundStyle(.darkPrimary)
                            .font(.system(size: 14))
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                        ForEach(viewModel.favoriteCoins) { item in
                            FavoriteAssetItemView(viewModel: item, getFormatter: viewModel.getFormatter, percentageFormatter: viewModel.percentageFormatter)
                                .listRowBackground(Color(.white))
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                        }
                        .onDelete { indexes in
                            Task { await viewModel.swipeToDelete(at: indexes) }
                        }
                        Text("|← Swipe left to remove asset")
                            .foregroundStyle(.darkPrimary)
                            .font(.system(size: 14))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                        
                    }
                    .listStyle(.plain)
                    .background(Color(.backgroundPrimary))
                }
            }
            .task {
                await viewModel.viewTask()
            }
            .onDisappear(perform: viewModel.onDisappear)
            .navigationTitle("Exchange Rates")
            .navigationBarTitleDisplayMode(.inline)
            .alert(viewModel.errorModel?.title ?? "", isPresented: $viewModel.isErrorPresented) {
                Button("OK") {}
            } message: {
                Text(viewModel.errorModel?.message ?? "")
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.addButtonTapped()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3.weight(.medium))
                    }
                    .accessibilityIdentifier("AddAssetButton")
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        Task { await viewModel.trashButtonTapped() }
                    } label: {
                        Image(systemName: "trash.fill")
                            .font(.title3.weight(.medium))
                    }
                    .accessibilityIdentifier("DeleteAssetsButton")
                }
            }
        }
    }
    
    private var navigations: some View {
        // Used the default navigation logic to avoid spending too much time on the test task.
        NavigationLink("", isActive: $viewModel.isAddAssetPresenting) {
            if viewModel.isAddAssetPresenting {
                AddAssetViewBuilder().build()
            }
        }
        .hidden()
    }
}
