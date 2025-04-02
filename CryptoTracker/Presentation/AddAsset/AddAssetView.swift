//
//  AddAssetView.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

import SwiftUI

struct AddAssetView: View {
    @StateObject var viewModel: AddAssetViewModel
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .tint(Color(.darkPrimary))
            } else if viewModel.coins.isEmpty {
                Text("No results found")
                    .foregroundColor(Color(.darkPrimary))
                    .font(.system(size: 16, weight: .bold))
            } else {
                List(viewModel.coins) { item in
                    AddAssetItemView(viewModel: item) {
                        Task { await viewModel.favoriteButtonTapped(item: item) }
                    }
                    .listRowBackground(Color(.white))
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                }
                .accessibilityIdentifier("AssetsList")
                .listStyle(.plain)
                .background(Color(.backgroundPrimary))
            }
        }
        .task {
            await viewModel.viewTask()
        }
        .navigationTitle("Add Asset")
        .navigationBarTitleDisplayMode(.inline)
        .alert(viewModel.errorModel?.title ?? "", isPresented: $viewModel.isErrorPresented) {
            Button("OK") {}
        } message: {
            Text(viewModel.errorModel?.message ?? "")
        }
        .searchable(text: $viewModel.searchQuery, placement: .navigationBarDrawer(displayMode: .always))
    }
}
