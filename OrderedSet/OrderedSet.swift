//
//  OrderedSet.swift
//  OrderedSet
//
//  Created by Zach Langley on 11/17/15.
//  Copyright © 2015 Zach Langley. All rights reserved.
//

public struct OrderedSet<Element: Hashable>: ArrayLiteralConvertible, RangeReplaceableCollectionType {
    private var indexForElement: Dictionary<Element, Int> = [:]
    private var array: Array<Element> = []

    // MARK: ArrayLiteralConvertible

    public init(arrayLiteral elements: Element...) {
        self.replaceRange(0..<0, with: elements)
    }

    // MARK: RangeReplaceableCollectionType

    public init() { }

    public mutating func reserveCapacity(n: Int) {
        array.reserveCapacity(n)
    }

    public mutating func replaceRange<C : CollectionType where C.Generator.Element == Element>(subRange: Range<Int>, with newElements: C) {
        for elementToRemove in array[subRange] {
            indexForElement.removeValueForKey(elementToRemove)
        }
        array.removeRange(subRange)

        let elementsToInsert = newElements.filter { indexForElement[$0] == nil }

        array.replaceRange(subRange.startIndex..<subRange.startIndex, with: elementsToInsert)
        for (idx, elementToInsert) in elementsToInsert.enumerate() {
            indexForElement[elementToInsert] = subRange.startIndex + idx
        }
    }
}

extension OrderedSet: MutableCollectionType {
    public var startIndex: Int { return 0 }
    public var endIndex: Int { return array.count }

    public subscript (position: Int) -> Element {
        get { return array[position] }
        set { replaceRange(position...position, with: [newValue]) }
    }

    public subscript (bounds: Range<Int>) -> ArraySlice<Element> {
        get { return array[bounds] }
        set { replaceRange(bounds, with: newValue) }
    }
}

extension OrderedSet: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String { return array.description }
    public var debugDescription: String { return array.description }
}

func == <T, C: CollectionType where C.Generator.Element == T>(lhs: OrderedSet<T>, rhs: C) -> Bool {
    for element in lhs {
        if !rhs.contains(element) {
            return false
        }
    }

    for element in rhs {
        if !lhs.contains(element) {
            return false
        }
    }

    return true
}

func != <T, C: CollectionType where C.Generator.Element == T>(lhs: OrderedSet<T>, rhs: C) -> Bool {
    return !(lhs == rhs)
}
