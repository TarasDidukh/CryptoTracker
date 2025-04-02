//
//  AddAssetItemView.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

import SwiftUI

struct AddAssetItemView: View {
    @ObservedObject var viewModel: AddAssetItemViewModel
    let onFavoriteTapped: () -> Void
    
    private var model: CoinAsset { viewModel.model }
    
    var body: some View {
        HStack(spacing: 8) {
            CachedAsyncImageView(url: model.image.flatMap(URL.init)) { image in
                image
                    .resizable()
                    .frame(width: 35, height: 35)
            } placeholder: {
                Image(systemName: "questionmark.circle.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundStyle(Color(.darkPrimary))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(model.symbol.uppercased())
                    .foregroundStyle(.darkPrimary)
                    .font(.system(size: 14).weight(.bold))
                    .accessibilityIdentifier("SymbolLabel")
                Text(model.name)
                    .foregroundStyle(Color(.gray))
                    .font(.system(size: 14))
            }
            .lineLimit(1)
            
            Spacer()
            
            Button {
                onFavoriteTapped()
            } label: {
                Image(systemName: viewModel.isFavorite ? "star.fill" : "star")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(viewModel.isFavorite ? Color(.gold) : Color(.darkPrimary))
                    .animation(.smooth, value: viewModel.isFavorite)
            }
            .accessibilityIdentifier("StarButton")
        }
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(color: Color(.darkPrimary).opacity(0.1), radius: 4, x: 0, y: 2)
        )
        .padding(.vertical, 8)
        .listRowBackground(Color(.backgroundPrimary))
    }
}

#Preview {
    AddAssetItemView(viewModel: AddAssetItemViewModel(model: CoinAsset(id: "id", name: "Bitco sdfsdf sdf sdf sd fsdfkkk", symbol: "BTC", marketCapRank: 1, image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png", isFavorite: true))) {}
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .background(Color(.itemBackground))
}
