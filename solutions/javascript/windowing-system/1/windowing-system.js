// @ts-check

// Size class
export class Size {
  constructor(width = 80, height = 60) {
    this.width = width;
    this.height = height;
  }

  resize(newWidth, newHeight) {
    this.width = newWidth;
    this.height = newHeight;
  }
}

// Position class
export class Position {
  constructor(x = 0, y = 0) {
    this.x = x;
    this.y = y;
  }

  move(newX, newY) {
    this.x = newX;
    this.y = newY;
  }
}

// ProgramWindow class
export class ProgramWindow {
  constructor() {
    this.screenSize = new Size(800, 600);
    this.size = new Size();
    this.position = new Position();
  }

  resize(newSize) {
    // Minimum size is 1
    let newWidth = Math.max(1, newSize.width);
    let newHeight = Math.max(1, newSize.height);
    
    // Cannot exceed screen bounds based on current position
    const maxWidth = this.screenSize.width - this.position.x;
    const maxHeight = this.screenSize.height - this.position.y;
    
    // Clip to maximum allowed size
    newWidth = Math.min(newWidth, maxWidth);
    newHeight = Math.min(newHeight, maxHeight);
    
    this.size.resize(newWidth, newHeight);
  }

  move(newPosition) {
    // Minimum position is 0
    let newX = Math.max(0, newPosition.x);
    let newY = Math.max(0, newPosition.y);
    
    // Cannot exceed screen bounds based on current size
    const maxX = this.screenSize.width - this.size.width;
    const maxY = this.screenSize.height - this.size.height;
    
    // Clip to maximum allowed position
    newX = Math.min(newX, maxX);
    newY = Math.min(newY, maxY);
    
    this.position.move(newX, newY);
  }
}

// changeWindow function
export function changeWindow(programWindow) {
  const newSize = new Size(400, 300);
  const newPosition = new Position(100, 150);
  
  programWindow.resize(newSize);
  programWindow.move(newPosition);
  
  return programWindow;
}