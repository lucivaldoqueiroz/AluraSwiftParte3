//
//  RefeicaoDao.swift
//  eggplant-brownie
//
//  Created by Lucivaldo Queiroz on 12/07/22.
//

import Foundation


class RefeicaoDao {
    
    func save(_ refeicoes: [Refeicao]) {
        
        //guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        //let caminho = diretorio.appendingPathComponent("refeicao")
        guard let caminho = recuperaCaminho() else { return }
        do {
            let dados = try NSKeyedArchiver.archivedData(withRootObject: refeicoes, requiringSecureCoding: false)
            try dados.write(to: caminho)
        }  catch {
            print(error.localizedDescription)
        }
    }
    
    func recupera() -> [Refeicao] {
        guard let caminho = recuperaCaminho() else { return [] }
        do {
            let dados = try Data(contentsOf: caminho)
            guard let refeicoesSalvas = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as? Array<Refeicao> else { return [] }
                return refeicoesSalvas
        }  catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func recuperaCaminho() -> URL? {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let caminho = diretorio.appendingPathComponent("refeicoes")
        
        return caminho
    }
}


