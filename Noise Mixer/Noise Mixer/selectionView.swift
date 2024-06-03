//  Noise Mixer
//John Lucaccioni: joluca@iu.edu
//Juntao Chi: chijun@iu.edu
//Submit date: April 28

import SwiftUI

struct selectionView: View {
    @EnvironmentObject var noiseRepo: NoiseRepo
    @EnvironmentObject var selectedNoises: SelectedNoises
    @EnvironmentObject var checked: IsChecked
    //Has to be updated if noises are added to match # of total noises
//    @State private var backgroundColor: [Color] = [Color.white, Color.white, Color.white, Color.white, Color.white]
    
    
    var body: some View {
        ZStack{
            Rectangle()
                            .fill(.ultraThinMaterial)
                            .edgesIgnoringSafeArea(.all)

        
            VStack{
                
    //            Text("Select 4 noises")
    //                .font(.title)
    //                .padding()
    //
    //            Divider()
    //
                List{
                    ForEach(0..<noiseRepo.noiseList.count, id: \.self) { index in
                        let option = noiseRepo.noiseList[index]
                        HStack{
                            option.icon
    //                            .foregroundColor(backgroundColor[index])
                            Text(option.soundEffectName)
                            Spacer()
                            Image(systemName: "checkmark")
    //                            .foregroundColor(.blue)
                                .opacity(checked.isChecked[index] ? 1 : 0)
                        }.onTapGesture{
                            if checked.isChecked[index] == true{
                                checked.isChecked[index].toggle()
    //                            backgroundColor[index] = backgroundColor[index] == Color.white ? option.color : Color.white
                            }
                            else {
                                if checkLessThan4OptionsSelected(isChecked: checked.isChecked){
                                    checked.isChecked[index].toggle()
    //                                backgroundColor[index] = backgroundColor[index] == Color.white ? option.color : Color.white
                                }
                            }
                            
                        }.onAppear{
    //                        if checked.isChecked[index] == true{
    //                            backgroundColor[index] = option.color
    //                        }
                        }
                    }
                }
                //Add selected options to selectedNoises
            }.onDisappear{
                //If less than 4 options are selected, select for them
                if checkLessThan4OptionsSelected(isChecked: checked.isChecked){
                    for index in checked.isChecked.indices{
                        if !checked.isChecked[index]{
                            checked.isChecked[index] = !checked.isChecked[index]
                        }
                        if !checkLessThan4OptionsSelected(isChecked: checked.isChecked){
                            
                            break
                        }
                        
                    }
                    
                }
                var temp_selected_noises: [Noise] = []
                for index in checked.isChecked.indices{
                    if checked.isChecked[index]{
                        temp_selected_noises.append(noiseRepo.noiseList[index])
                    }
                }
                selectedNoises.setSelectedNoiseList(temp_selected_noises)
            }
        }
    }
}

func checkLessThan4OptionsSelected(isChecked: [Bool]) -> Bool{
    let selectedCount = isChecked.filter{$0}.count
    if selectedCount < 4{
        return true
    }
    return false
}

struct selectionView_Previews: PreviewProvider {
    static var previews: some View {
        let noiseRepo = NoiseRepo()
        let selectedNoises = SelectedNoises()
        let checked = IsChecked()
        
//        let backgroundColor: [Color] = [Color.white, Color.white, Color.white, Color.white, Color.white]
        
        selectionView()
            .environmentObject(noiseRepo)
            .environmentObject(selectedNoises)
            .environmentObject(checked)
    }
}
