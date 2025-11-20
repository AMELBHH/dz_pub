import 'package:dz_pub/core/styling/App_text_style.dart';
import 'package:flutter/material.dart';

class SelectableItem extends StatefulWidget {
  final String label; 
  final Function(bool)? onChanged; 
  const SelectableItem({super.key, required this.label, this.onChanged});

  @override
  State<SelectableItem> createState() => _SelectableItemState();
}

class _SelectableItemState extends State<SelectableItem> {
  bool isSelected = false; 

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(isSelected);
        }
      },
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
     
        children: [
          const SizedBox(width: 10),
          Text(
            widget.label,
            style: AppTextStyle.descriptionText,
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.transparent,
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.grey,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: isSelected
                ? const Icon(Icons.check, color: Colors.white, size: 18)
                : null,
          ),
        
        ],
      ),
    );
  }
}
