extension Array {
    func enumeratedPairs() -> [(Index, Element, Index, Element)] {
        return enumerated().map { index, element in
            let index2 = (index - 1) < 0 ? count - 1 : index - 1
            let element2 = self[index2]
            return (index2, element2, index, self[index])
        }
    }
}
