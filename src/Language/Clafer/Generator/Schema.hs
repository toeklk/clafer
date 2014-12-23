{-
 Copyright (C) 2012 Jimmy Liang <http://gsd.uwaterloo.ca>

 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 of the Software, and to permit persons to whom the Software is furnished to do
 so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
-}
module Language.Clafer.Generator.Schema where
xsd :: String
xsd = concat [ ""
  , "<!-- ........................................................................ *\n"
  , "  *   Clafer Project                                                          *\n"
  , "  *   http://clafer.org                                                       *\n"
  , "  *                                                                           *\n"
  , "  *   File description: XML schema of Clafer intermediate representation (IR) *\n"
  , "  *   Depends on: Haskell IR data types defined for clafer                    *\n"
  , "  *   Author: Leonardo Passos <lpassos@gsd.uwaterloo.ca>                      *\n"
  , "  *   Contributors: Jimmy Liang <jliang@gsd.uwaterloo.ca>                     *\n"
  , "  *   Date: October 19th, 2011                                                *\n"
  , "  *   Last update: April 16th, 2012                                           *\n"
  , "  *                                                                           *\n"
  , "  *   Generate scala classes with:                                            *\n"
  , "  *   scalaxb -p gsd.clafer.ir ClaferIR.xsd                                   *\n"
  , "  *           - -protocol-file ClaferIR_XmlProtocol.scala                     *\n"
  , "  * ......................................................................... *\n"
  , "  */\n"
  , "-->\n"
  , "<xs:schema targetNamespace=\"http://clafer.org/ir\"\n"
  , "           elementFormDefault=\"qualified\"\n"
  , "           xmlns=\"http://clafer.org/ir\"\n"
  , "           xmlns:xs=\"http://www.w3.org/2001/XMLSchema\"\n"
  , "           xmlns:cl=\"http://clafer.org/ir\">\n"
  , "\n"
  , "  <!-- . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .-->\n"
  , "  <!--\n"
  , "data IType\n"
  , "  = TBoolean\n"
  , "  | TString\n"
  , "  | TInteger\n"
  , "  | TReal\n"
  , "  | TClafer [UID]\n"
  , "  -->\n"
  , "  <xs:complexType name=\"IType\" abstract=\"true\"/>\n"
  , "  <xs:element name=\"Type\" type=\"cl:IType\"/>\n"
  , "\n"
  , "  <xs:complexType name=\"IBoolean\">\n"
  , "      <xs:complexContent>\n"
  , "          <xs:extension base=\"cl:IType\"/>\n"
  , "      </xs:complexContent>\n"
  , "  </xs:complexType>\n"
  , "\n"
  , "  <xs:complexType name=\"IString\">\n"
  , "      <xs:complexContent>\n"
  , "          <xs:extension base=\"cl:IType\"/>\n"
  , "      </xs:complexContent>\n"
  , "  </xs:complexType>\n"
  , "\n"
  , "  <xs:complexType name=\"IInteger\">\n"
  , "      <xs:complexContent>\n"
  , "          <xs:extension base=\"cl:IType\"/>\n"
  , "      </xs:complexContent>\n"
  , "  </xs:complexType>\n"
  , "\n"
  , "  <xs:complexType name=\"IReal\">\n"
  , "      <xs:complexContent>\n"
  , "          <xs:extension base=\"cl:IType\"/>\n"
  , "      </xs:complexContent>\n"
  , "  </xs:complexType>\n"
  , "\n"
  , "  <xs:complexType name=\"ISet\">\n"
  , "      <xs:complexContent>\n"
  , "          <xs:extension base=\"cl:IType\"/>\n"
  , "      </xs:complexContent>\n"
  , "  </xs:complexType>\n"
  , "\n"
  , "  <!-- . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .-->\n"
  , "  <!--\n"
  , "data IModule\n"
  , "  = IModule\n"
  , "    { _mName :: String\n"
  , "    , _mDecls :: [IElement]\n"
  , "    }\n"
  , "  -->\n"
  , "\n"
  , "  <xs:complexType name=\"IModule\">\n"
  , "      <xs:sequence>\n"
  , "          <xs:element name=\"Name\" type=\"xs:string\"/>\n"
  , "          <xs:element ref=\"Declaration\" minOccurs=\"0\" maxOccurs=\"unbounded\"/>\n"
  , "      </xs:sequence>\n"
  , "  </xs:complexType>\n"
  , "\n"
  , "  <xs:element name=\"Module\" type=\"cl:IModule\"/>\n"
  , "\n"
  , "  <!-- . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .-->\n"
  , "  <!--\n"
  , "data IClafer\n"
  , "  = IClafer\n"
  , "    { _cinPos :: Span\n"
  , "    , _isAbstract :: Bool\n"
  , "    , _gcard :: Maybe IGCard\n"
  , "    , _ident :: CName\n"
  , "    , _uid :: UID\n"
  , " , _parentUID :: UID\n"
  , "    , _super:: ISuper\n"
  , "    , _card :: Maybe Interval\n"
  , "    , _glCard :: Interval\n"
  , "    , _elements :: [IElement]\n"
  , "    }\n"
  , "  -->\n"
  , "  <xs:complexType name=\"IClafer\">\n"
  , "      <xs:complexContent>\n"
  , "          <xs:extension base=\"IElement\">\n"
  , "            <xs:sequence>\n"
  , "                <xs:element name=\"Position\">\n"
  , "                  <xs:complexType>\n"
  , "                      <xs:sequence>\n"
  , "                          <xs:element name=\"Start\">\n"
  , "                              <xs:complexType>\n"
  , "                                  <xs:sequence>\n"
  , "                                      <xs:element ref=\"IntLiteral\" minOccurs=\"2\" maxOccurs=\"2\"/>\n"
  , "                                  </xs:sequence>\n"
  , "                              </xs:complexType>\n"
  , "                          </xs:element>\n"
  , "                          <xs:element name=\"End\">\n"
  , "                              <xs:complexType>\n"
  , "                                  <xs:sequence>\n"
  , "                                      <xs:element ref=\"IntLiteral\" minOccurs=\"2\" maxOccurs=\"2\"/>\n"
  , "                                  </xs:sequence>\n"
  , "                              </xs:complexType>\n"
  , "                          </xs:element>\n"
  , "                      </xs:sequence>\n"
  , "                  </xs:complexType>\n"
  , "                </xs:element>\n"
  , "                <xs:element name=\"IsAbstract\" type=\"xs:boolean\"/>\n"
  , "                <xs:element name=\"GroupCard\"  type=\"cl:IGroupCard\" minOccurs=\"0\" maxOccurs=\"1\"/>\n"
  , "                <xs:element name=\"Id\"         type=\"xs:string\"/>\n"
  , "                <xs:element name=\"UniqueId\"   type=\"xs:string\"/>\n"
  , "                <xs:element name=\"ParentUniqueId\" type=\"xs:string\"/>\n"
  , "                <xs:element name=\"Supers\"     type=\"cl:ISuper\"/>\n"
  , "                <xs:element name=\"Card\"       type=\"cl:IInterval\" minOccurs=\"0\" maxOccurs=\"1\"/>\n"
  , "                <xs:element name=\"GlobalCard\" type=\"cl:IInterval\"/>\n"
  , "                <xs:element ref=\"Declaration\" minOccurs=\"0\" maxOccurs=\"unbounded\"/>\n"
  , "            </xs:sequence>\n"
  , "          </xs:extension>\n"
  , "      </xs:complexContent>\n"
  , "  </xs:complexType>\n"
  , "\n"
  , "  <!-- . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .-->\n"
  , "  <!--\n"
  , "data IElement\n"
  , "  = IEClafer\n"
  , "    { _iClafer :: IClafer\n"
  , "    }\n"
  , "  | IEConstraint\n"
  , "    { _isHard :: Bool\n"
  , "    , _cpexp :: PExp\n"
  , "    }\n"
  , "  -- | Goal (optimization objective)\n"
  , "  | IEGoal\n"
  , "    { _isMaximize :: Bool\n"
  , "    , _cpexp :: PExp\n"
  , "    }\n"
  , "   -->\n"
  , "\n"
  , "  <xs:complexType name=\"IElement\" abstract=\"true\"/>\n"
  , "  <xs:element name=\"Declaration\" type=\"IElement\"/>\n"
  , "\n"
  , "  <!-- No need to create IEClafer type. IClafer is already a subtype\n"
  , "       of IElement\n"
  , "    -->\n"
  , "\n"
  , "  <xs:complexType name=\"IConstraint\">\n"
  , "    <xs:complexContent>\n"
  , "      <xs:extension base=\"cl:IElement\">\n"
  , "          <xs:sequence>\n"
  , "              <xs:element name=\"IsHard\"    type=\"xs:boolean\"/>\n"
  , "              <xs:element name=\"ParentExp\" type=\"cl:IParentExp\"/>\n"
  , "          </xs:sequence>\n"
  , "      </xs:extension>\n"
  , "\n"
  , "    </xs:complexContent>\n"
  , "  </xs:complexType>\n"
  , "\n"
  , "  <xs:complexType name=\"IGoal\">\n"
  , "    <xs:complexContent>\n"
  , "      <xs:extension base=\"cl:IElement\">\n"
  , "          <xs:sequence>\n"
  , "              <xs:element name=\"IsMaximize\"    type=\"xs:boolean\"/>\n"
  , "              <xs:element name=\"ParentExp\" type=\"cl:IParentExp\"/>\n"
  , "          </xs:sequence>\n"
  , "      </xs:extension>\n"
  , "\n"
  , "    </xs:complexContent>\n"
  , "  </xs:complexType>\n"
  , "\n"
  , "  <!-- . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .-->\n"
  , "  <!--\n"
  , "data ISuper\n"
  , "  = ISuper\n"
  , "    { _isOverlapping :: Bool\n"
  , "    , _supers :: [PExp]\n"
  , "    }\n"
  , "  -->\n"
  , "  <xs:complexType name=\"ISuper\">\n"
  , "    <xs:sequence>\n"
  , "        <xs:element name=\"IsOverlapping\" type=\"xs:boolean\"/>\n"
  , "        <xs:element name=\"Super\"         type=\"cl:IParentExp\" minOccurs=\"0\" maxOccurs=\"unbounded\"/>\n"
  , "    </xs:sequence>\n"
  , "  </xs:complexType>\n"
  , "\n"
  , "  <!-- . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .-->\n"
  , "  <!--\n"
  , "data IGCard\n"
  , "  = IGCard\n"
  , "    { _isKeyword :: Bool\n"
  , "    , _interval :: Interval\n"
  , "    }\n"
  , "  -->\n"
  , "\n"
  , "  <xs:complexType name=\"IGroupCard\">\n"
  , "    <xs:sequence>\n"
  , "        <xs:element name=\"IsKeyword\" type=\"xs:boolean\"/>\n"
  , "        <xs:element name=\"Interval\"  type=\"cl:IInterval\"/>\n"
  , "    </xs:sequence>\n"
  , "  </xs:complexType>\n"
  , "\n"
  , "  <!-- . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .-->\n"
  , "  <!-- type Interval = (Integer, ExInteger) -->\n"
  , "\n"
  , "  <xs:complexType name=\"IInterval\">\n"
  , "      <xs:sequence>\n"
  , "          <xs:element name=\"Min\">\n"
  , "            <xs:complexType>\n"
  , "                <xs:sequence>\n"
  , "                    <xs:element ref=\"IntLiteral\"/>\n"
  , "                </xs:sequence>\n"
  , "            </xs:complexType>\n"
  , "          </xs:element>\n"
  , "          <xs:element name=\"Max\">\n"
  , "            <xs:complexType>\n"
  , "                <xs:sequence>\n"
  , "                    <xs:element ref=\"IntLiteral\"/>\n"
  , "                </xs:sequence>\n"
  , "            </xs:complexType>\n"
  , "          </xs:element>\n"
  , "      </xs:sequence>\n"
  , "  </xs:complexType>\n"
  , "\n"
  , "  <!-- . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .-->\n"
  , "  <!--\n"
  , "data PExp\n"
  , "  = PExp\n"
  , "    { _iType :: Maybe IType\n"
  , "    , _pid :: String\n"
  , "    , _inPos :: Span\n"
  , "    , _exp :: IExp\n"
  , "    }\n"
  , "  -->\n"
  , "\n"
  , "  <xs:complexType name=\"IParentExp\">\n"
  , "      <xs:sequence>\n"
  , "          <xs:element name=\"Type\"     type=\"cl:IType\" minOccurs=\"0\" maxOccurs=\"1\"/>\n"
  , "          <xs:element name=\"ParentId\" type=\"xs:string\" minOccurs=\"0\" maxOccurs=\"1\"/>\n"
  , "          <xs:element name=\"Position\">\n"
  , "              <xs:complexType>\n"
  , "                  <xs:sequence>\n"
  , "                      <xs:element name=\"Start\">\n"
  , "                          <xs:complexType>\n"
  , "                              <xs:sequence>\n"
  , "                                  <xs:element ref=\"IntLiteral\" minOccurs=\"2\" maxOccurs=\"2\"/>\n"
  , "                              </xs:sequence>\n"
  , "                          </xs:complexType>\n"
  , "                      </xs:element>\n"
  , "                      <xs:element name=\"End\">\n"
  , "                          <xs:complexType>\n"
  , "                              <xs:sequence>\n"
  , "                                  <xs:element ref=\"IntLiteral\" minOccurs=\"2\" maxOccurs=\"2\"/>\n"
  , "                              </xs:sequence>\n"
  , "                          </xs:complexType>\n"
  , "                      </xs:element>\n"
  , "                  </xs:sequence>\n"
  , "              </xs:complexType>\n"
  , "          </xs:element>\n"
  , "          <xs:element name=\"Exp\"      type=\"cl:IExp\"/>\n"
  , "      </xs:sequence>\n"
  , "  </xs:complexType>\n"
  , "\n"
  , "\n"
  , "  <!-- ......................................................................-->\n"
  , "  <!--\n"
  , "data IExp\n"
  , "  = IDeclPExp\n"
  , "    { _quant :: IQuant\n"
  , "    , _oDecls :: [IDecl]\n"
  , "    , _bpexp :: PExp\n"
  , "    }\n"
  , "  | IFunExp\n"
  , "    { _op :: String\n"
  , "    , _exps :: [PExp]\n"
  , "    }\n"
  , "  | IInt\n"
  , "    { _iint :: Integer\n"
  , "    }\n"
  , "  | IDouble\n"
  , "    { _idouble :: Double\n"
  , "    }\n"
  , "  | IStr\n"
  , "    { _istr :: String\n"
  , "    }\n"
  , "  | IClaferId\n"
  , "    { _modName :: String\n"
  , "    , _sident :: CName\n"
  , "    , _isTop :: Bool\n"
  , "    , _binding :: ClaferBinding\n"
  , "    }\n"
  , "   -->\n"
  , "  <xs:complexType name=\"IExp\" abstract=\"true\"/>\n"
  , "\n"
  , "  <xs:complexType name=\"IDeclarationParentExp\">\n"
  , "      <xs:complexContent>\n"
  , "          <xs:extension base=\"cl:IExp\">\n"
  , "              <xs:sequence>\n"
  , "                  <xs:element name=\"Quantifier\"    type=\"cl:IQuantifier\"/>\n"
  , "                  <xs:element name=\"Declaration\"   type=\"cl:IDeclaration\" minOccurs=\"0\" maxOccurs=\"unbounded\"/>\n"
  , "                  <xs:element name=\"BodyParentExp\" type=\"cl:IParentExp\"/>\n"
  , "              </xs:sequence>\n"
  , "          </xs:extension>\n"
  , "      </xs:complexContent>\n"
  , "  </xs:complexType>\n"
  , "\n"
  , "  <xs:complexType name=\"IFunctionExp\">\n"
  , "      <xs:complexContent>\n"
  , "          <xs:extension base=\"IExp\">\n"
  , "              <xs:sequence>\n"
  , "                  <xs:element name=\"Operation\" type=\"xs:string\"/>\n"
  , "                  <xs:element name=\"Argument\" minOccurs=\"0\" maxOccurs=\"unbounded\" type=\"IParentExp\"/>\n"
  , "              </xs:sequence>\n"
  , "          </xs:extension>\n"
  , "      </xs:complexContent>\n"
  , "  </xs:complexType>\n"
  , "\n"
  , "  <xs:complexType name=\"IIntExp\">\n"
  , "      <xs:complexContent>\n"
  , "          <xs:extension base=\"IExp\">\n"
  , "              <xs:sequence>\n"
  , "                 <xs:element ref=\"IntLiteral\"/>\n"
  , "              </xs:sequence>\n"
  , "          </xs:extension>\n"
  , "      </xs:complexContent>\n"
  , "  </xs:complexType>\n"
  , "\n"
  , "  <xs:complexType name=\"IDoubleExp\">\n"
  , "      <xs:complexContent>\n"
  , "          <xs:extension base=\"IExp\">\n"
  , "              <xs:sequence>\n"
  , "                 <xs:element ref=\"DoubleLiteral\"/>\n"
  , "              </xs:sequence>\n"
  , "          </xs:extension>\n"
  , "      </xs:complexContent>\n"
  , "  </xs:complexType>\n"
  , "\n"
  , "  <xs:complexType name=\"IStringExp\">\n"
  , "      <xs:complexContent>\n"
  , "          <xs:extension base=\"IExp\">\n"
  , "              <xs:sequence>\n"
  , "                 <xs:element ref=\"StringLiteral\"/>\n"
  , "              </xs:sequence>\n"
  , "          </xs:extension>\n"
  , "      </xs:complexContent>\n"
  , "  </xs:complexType>\n"
  , "\n"
  , "\n"
  , "  <xs:complexType name=\"IClaferId\">\n"
  , "      <xs:complexContent>\n"
  , "          <xs:extension base=\"IExp\">\n"
  , "              <xs:sequence>\n"
  , "                  <xs:element name=\"ModuleName\" type=\"xs:string\" minOccurs=\"0\" maxOccurs=\"1\"/>\n"
  , "                  <xs:element name=\"Id\"         type=\"xs:string\" />\n"
  , "                  <xs:element name=\"IsTop\"      type=\"xs:boolean\"/>\n"
  , "                  <xs:element name=\"Bind\"       type=\"xs:string\" />\n"
  , "              </xs:sequence>\n"
  , "          </xs:extension>\n"
  , "      </xs:complexContent>\n"
  , "  </xs:complexType>\n"
  , "\n"
  , "  <!-- ......................................................................-->\n"
  , "  <!--\n"
  , "data IDecl\n"
  , "  = IDecl\n"
  , "    { _isDisj :: Bool    -- ^ is disjunct\n"
  , "    , _decls :: [CName]  -- ^ a list of local names\n"
  , "    , _body :: PExp      -- ^ set to which local names refer to\n"
  , "    }\n"
  , "    -->\n"
  , "\n"
  , "   <xs:complexType name=\"IDeclaration\">\n"
  , "       <xs:sequence>\n"
  , "           <xs:element name=\"IsDisjunct\"       type=\"xs:boolean\"/>\n"
  , "           <xs:element name=\"LocalDeclaration\" type=\"xs:string\" minOccurs=\"0\" maxOccurs=\"unbounded\"/>\n"
  , "           <xs:element name=\"Body\"             type=\"cl:IParentExp\"/>\n"
  , "       </xs:sequence>\n"
  , "   </xs:complexType>\n"
  , "\n"
  , "  <!-- ......................................................................-->\n"
  , "  <!--\n"
  , "data IQuant\n"
  , "  = INo\n"
  , "  | ILone\n"
  , "  | IOne\n"
  , "  | ISome\n"
  , "  | IAll\n"
  , "   -->\n"
  , "\n"
  , "   <xs:complexType name=\"IQuantifier\" abstract=\"true\"/>\n"
  , "\n"
  , "   <xs:complexType name=\"INo\">\n"
  , "       <xs:complexContent>\n"
  , "           <xs:extension base=\"cl:IQuantifier\"/>\n"
  , "       </xs:complexContent>\n"
  , "   </xs:complexType>\n"
  , "\n"
  , "   <xs:complexType name=\"ILone\">\n"
  , "       <xs:complexContent>\n"
  , "           <xs:extension base=\"cl:IQuantifier\"/>\n"
  , "       </xs:complexContent>\n"
  , "   </xs:complexType>\n"
  , "\n"
  , "   <xs:complexType name=\"IOne\">\n"
  , "       <xs:complexContent>\n"
  , "           <xs:extension base=\"cl:IQuantifier\"/>\n"
  , "       </xs:complexContent>\n"
  , "   </xs:complexType>\n"
  , "\n"
  , "   <xs:complexType name=\"ISome\">\n"
  , "       <xs:complexContent>\n"
  , "           <xs:extension base=\"cl:IQuantifier\"/>\n"
  , "       </xs:complexContent>\n"
  , "   </xs:complexType>\n"
  , "\n"
  , "   <xs:complexType name=\"IAll\">\n"
  , "       <xs:complexContent>\n"
  , "           <xs:extension base=\"cl:IQuantifier\"/>\n"
  , "       </xs:complexContent>\n"
  , "   </xs:complexType>\n"
  , "\n"
  , " <!-- ......................................................................-->\n"
  , "\n"
  , " <xs:element name=\"IntLiteral\"    type=\"xs:integer\"/>\n"
  , " <xs:element name=\"DoubleLiteral\" type=\"xs:double\"/>\n"
  , " <xs:element name=\"StringLiteral\" type=\"xs:string\"/>\n"
  , "\n"
  , "</xs:schema>\n"
  , ""]
