//
//  EqualTripleSplitView.swift
//  Rialto
//
//  SwiftUI's HSplitView does not reliably honor `.frame(idealWidth:)` when
//  deciding the initial split — in practice it tends to favor whichever
//  pane's content wants more horizontal room (e.g. a longer subtitle),
//  regardless of matching idealWidth hints on both sides. This wraps
//  NSSplitViewController directly and sets the divider positions exactly
//  once real layout has happened, giving a guaranteed equal starting split
//  while keeping normal native resize behavior (drag, cursors) afterward.
//

import SwiftUI
import AppKit

struct EqualTripleSplitView<Left: View, Middle: View, Right: View>: NSViewControllerRepresentable {
    let left: Left
    let middle: Middle
    let right: Right
    var middleWidth: CGFloat = 50
    var minPaneWidth: CGFloat = 300

    func makeNSViewController(context: Context) -> EqualSplitViewController {
        let controller = EqualSplitViewController()
        controller.middleWidth = middleWidth
        controller.splitView.isVertical = true
        controller.splitView.dividerStyle = .thin

        let leftItem = NSSplitViewItem(viewController: NSHostingController(rootView: left))
        leftItem.minimumThickness = minPaneWidth
        leftItem.canCollapse = false

        let middleItem = NSSplitViewItem(viewController: NSHostingController(rootView: middle))
        middleItem.minimumThickness = middleWidth
        middleItem.maximumThickness = middleWidth
        middleItem.canCollapse = false

        let rightItem = NSSplitViewItem(viewController: NSHostingController(rootView: right))
        rightItem.minimumThickness = minPaneWidth
        rightItem.canCollapse = false

        controller.addSplitViewItem(leftItem)
        controller.addSplitViewItem(middleItem)
        controller.addSplitViewItem(rightItem)

        return controller
    }

    func updateNSViewController(_ controller: EqualSplitViewController, context: Context) {
        if let vc = controller.splitViewItems[0].viewController as? NSHostingController<Left> {
            vc.rootView = left
        }
        if let vc = controller.splitViewItems[1].viewController as? NSHostingController<Middle> {
            vc.rootView = middle
        }
        if let vc = controller.splitViewItems[2].viewController as? NSHostingController<Right> {
            vc.rootView = right
        }
    }
}

final class EqualSplitViewController: NSSplitViewController {
    var middleWidth: CGFloat = 50
    private var didSetInitialSplit = false

    override func viewDidLayout() {
        super.viewDidLayout()

        // Only force the split once, the first time the split view actually
        // has a real, nonzero width to work with. After that, leave it
        // entirely alone so the user's own dragging is never overridden.
        guard !didSetInitialSplit, splitView.bounds.width > 0 else { return }

        let total = splitView.bounds.width
        let dividerThickness = splitView.dividerThickness
        let available = total - middleWidth - (dividerThickness * 2)
        guard available > 0 else { return }

        let leftWidth = (available / 2).rounded(.down)
        splitView.setPosition(leftWidth, ofDividerAt: 0)
        splitView.setPosition(leftWidth + dividerThickness + middleWidth, ofDividerAt: 1)

        didSetInitialSplit = true
    }
}
