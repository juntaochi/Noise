//  Noise Mixer
//John Lucaccioni: joluca@iu.edu
//Juntao Chi: chijun@iu.edu
//Submit date: April 28

import SwiftUI

struct selectionView: View {
    @EnvironmentObject var noiseRepo: NoiseRepo
    @EnvironmentObject var selectedNoises: SelectedNoises
    @EnvironmentObject var checked: IsChecked
    
    var body: some View {
        VStack{
            
            List{
                ForEach(0..<noiseRepo.noiseList.count, id: \.self) { index in
                    let option = noiseRepo.noiseList[index]
                    HStack{
                        option.icon
                        Text(option.noiseName)
                        Spacer()
                        Image(systemName: "checkmark")
                            .opacity(checked.isChecked[index] ? 1 : 0)
                    }.onTapGesture{
                        if checked.isChecked[index] == true{
                            checked.isChecked[index].toggle()
                        }
                        else {
                            if checkLessThan4OptionsSelected(isChecked: checked.isChecked){
                                checked.isChecked[index].toggle()
                            }
                        }
                    }
                }
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

        selectionView()
            .environmentObject(noiseRepo)
            .environmentObject(selectedNoises)
            .environmentObject(checked)
    }
}
