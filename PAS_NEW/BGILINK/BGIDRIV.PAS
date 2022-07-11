{************************************************}
{                                                }
{   BGI Demo Program                             }
{   Copyright (c) 1992 by Borland International  }
{                                                }
{************************************************}

unit BGIDriv;

{
  Sample unit to accompany BGILINK.PAS. This unit links the BGI graphics
  driver into a single TPU file. This makes it easy to link the driver files
  directly into an .EXE file. See BGILINK.PAS for more information.
}

interface

procedure EgaVgaDriverProc;

implementation

procedure EgaVgaDriverProc; external;
{$L EGAVGA.OBJ }

end.
