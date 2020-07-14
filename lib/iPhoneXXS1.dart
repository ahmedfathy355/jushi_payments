import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class iPhoneXXS1 extends StatelessWidget {
  final VoidCallback logo;
  iPhoneXXS1({
    Key key,
    this.logo,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(-171.0, 319.0),
            child:
                // Adobe XD layer: 'jonathan-roger-LY1e…' (shape)
                Container(
              width: 702.0,
              height: 426.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/city.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Container(
            width: 367.0,
            height: 640.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.0, -1.0),
                end: Alignment(0.0, 1.0),
                colors: [
                  const Color(0xffe2f8f6),
                  const Color(0xff87bde1),
                  const Color(0x1a85c0e8)
                ],
                stops: [0.0, 0.852, 1.0],
              ),
            ),
          ),
          Container(
            width: 367.0,
            height: 640.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.0, -1.0),
                end: Alignment(0.0, 1.0),
                colors: [
                  const Color(0x71142ded),
                  const Color(0x71a447ba),
                  const Color(0x713746fa)
                ],
                stops: [0.0, 0.468, 1.0],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(-117.0, 256.0),
            child: SvgPicture.string(
              _shapeSVG_eea3074c5ac045768b3d946f93c95fd3,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(37.0, 319.0),
            child: Container(
              width: 302.0,
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
                gradient: LinearGradient(
                  begin: Alignment(0.0, -1.0),
                  end: Alignment(0.0, 1.0),
                  colors: [const Color(0xffffffff), const Color(0xffeff3fd)],
                  stops: [0.0, 1.0],
                ),
                border: Border.all(width: 1.0, color: const Color(0xffd4bcfa)),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6)
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(37.0, 405.0),
            child: Container(
              width: 302.0,
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
                gradient: LinearGradient(
                  begin: Alignment(0.0, -1.0),
                  end: Alignment(0.0, 1.0),
                  colors: [const Color(0xffffffff), const Color(0xffeff3fd)],
                  stops: [0.0, 1.0],
                ),
                border: Border.all(width: 1.0, color: const Color(0xffd4bcfa)),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6)
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(37.0, 486.0),
            child: Container(
              width: 302.0,
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
                gradient: LinearGradient(
                  begin: Alignment(0.0, -1.0),
                  end: Alignment(0.0, 1.0),
                  colors: [const Color(0xff4323f5), const Color(0xff321caf)],
                  stops: [0.0, 1.0],
                ),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xff2508ff),
                      offset: Offset(0, 0),
                      blurRadius: 6)
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(37.0, 296.0),
            child: Text(
              'Username',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 15,
                color: const Color(0xff18181a),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(50.0, 335.0),
            child: Text(
              'John',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 15,
                color: const Color(0x7218181a),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(50.0, 417.0),
            child: Text(
              '·············',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 22,
                color: const Color(0x2f18181a),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(37.0, 382.0),
            child: Text(
              'Password',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 15,
                color: const Color(0xff18181a),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(37.0, 243.0),
            child: Text(
              'Login',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 30,
                color: const Color(0xff18181a),
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(99.0, 551.0),
            child: Text.rich(
              TextSpan(
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 15,
                  color: const Color(0xff3339ce),
                ),
                children: [
                  TextSpan(
                    text: 'Forget password ? |',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(
                    text: ' ',
                    style: TextStyle(
                      color: const Color(0xfff03b8e),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(
                    text: 'Sing up',
                    style: TextStyle(
                      color: const Color(0xfff03b8e),
                      fontWeight: FontWeight.w900,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(155.0, 85.0),
            child: Container(
              width: 84.0,
              height: 84.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(42.0, 42.0)),
                color: const Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6)
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(158.0, 502.0),
            child: Text(
              'Let’s Go',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 17,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(-117.0, 97.07),
            child:
                // Adobe XD layer: 'Color' (group)
                SvgPicture.string(
              _shapeSVG_104ddbe9d8bb4ac993ad0dd4706bfd60,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(164.36, 94.07),
            child:
                // Adobe XD layer: 'Color' (group)
                Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(11.999998092651367, 3),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 41.3,
                      height: 59.8,
                      child: GestureDetector(onTap: () => logo?.call()),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(156.0, 609.0),
            child: Text(
              'Faqs  |  Help',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 12,
                color: const Color(0xffd2d1f5),
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}

const String _shapeSVG_eea3074c5ac045768b3d946f93c95fd3 =
    '<svg viewBox="-117.0 256.0 628.0 640.0" ><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#ffffffff"  /><stop offset="1.0" stop-color="#00ffffff" stop-opacity="0.0" /></linearGradient></defs><path transform="translate(-117.0, 385.0)" d="M 314 0 L 628 511 L 0 511 Z" fill="url(#gradient)" fill-opacity="0.19" stroke="none" stroke-width="1" stroke-opacity="0.19" stroke-miterlimit="4" stroke-linecap="butt" /><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#ffffffff"  /><stop offset="1.0" stop-color="#00ffffff" stop-opacity="0.0" /></linearGradient></defs><path transform="translate(-117.0, 305.0)" d="M 314 0 L 628 511 L 0 511 Z" fill="url(#gradient)" fill-opacity="0.19" stroke="none" stroke-width="1" stroke-opacity="0.19" stroke-miterlimit="4" stroke-linecap="butt" /><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#ffffffff"  /><stop offset="1.0" stop-color="#00ffffff" stop-opacity="0.0" /></linearGradient></defs><path transform="translate(-117.0, 256.0)" d="M 314 0 L 628 511 L 0 511 Z" fill="url(#gradient)" fill-opacity="0.19" stroke="none" stroke-width="1" stroke-opacity="0.19" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _shapeSVG_104ddbe9d8bb4ac993ad0dd4706bfd60 =
    '<svg viewBox="-117.0 97.1 628.0 602.9" ><g transform="translate(164.36, 94.07)"><g transform="translate(12.0, 3.0)"><path transform="translate(-11.87, -2.11)" d="M 42.16074752807617 55.30840682983398 L 35.11465072631836 61.02948760986328 C 33.59804916381836 62.26183319091797 31.42510414123535 62.26183319091797 29.90850257873535 61.02948760986328 L 22.8624095916748 55.30840682983398 C 18.52101516723633 51.78137588500977 16.00018501281738 46.48573303222656 16 40.89218902587891 L 16 31.00000190734863 L 49.02212142944336 31.00000190734863 L 49.02212142944336 40.89321899414063 C 49.02212142944336 46.48542022705078 46.50194931030273 51.78069305419922 42.16137313842773 55.30789566040039 Z" fill="#f9e109" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-12.0, -2.68)" d="M 22.31941413879395 13 L 42.95823669433594 13 C 48.65749359130859 13 53.27765274047852 17.62015914916992 53.27765274047852 23.31941223144531 L 53.27764892578125 29.51106071472168 C 53.27764892578125 31.7907600402832 51.42958450317383 33.63882446289063 49.14988327026367 33.63882446289063 L 16.12776565551758 33.63882446289063 C 13.84806442260742 33.63882446289063 12 31.7907600402832 12 29.51106071472168 L 12 23.31941223144531 C 12 17.62015724182129 16.62016105651855 12.99999904632568 22.31941604614258 13 Z" fill="#fcbc04" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-12.0, -2.68)" d="M 53.22708511352539 22.31017303466797 C 53.08027648925781 22.31656646728516 52.93645858764648 22.35383796691895 52.80501937866211 22.4195613861084 L 49.57711029052734 19.19164657592773 L 51.38816833496094 17.38059043884277 C 50.99013900756836 16.81687164306641 50.53656768798828 16.29450416564941 50.03426361083984 15.82132625579834 C 50.02909851074219 15.82648944854736 50.02187728881836 15.82855319976807 50.01671981811523 15.83371257781982 L 48.11794281005859 17.73248291015625 L 44.93337631225586 14.54791259765625 L 45.57214736938477 13.90914058685303 C 45.70295715332031 13.77127361297607 45.79204940795898 13.59917736053467 45.82909774780273 13.41277503967285 C 45.08098602294922 13.19878578186035 44.31109237670898 13.07000827789307 43.53406524658203 13.02889633178711 L 43.47421264648438 13.08874702453613 L 43.40816879272461 13.02270221710205 C 43.25749969482422 13.01651096343994 43.10993194580078 13 42.95823669433594 13 L 40.89435577392578 13 C 40.89435577392578 13.27344608306885 41.00305938720703 13.53590488433838 41.19655990600586 13.7294282913208 L 42.01504135131836 14.54791259765625 L 38.83047103881836 17.73248291015625 L 35.64590454101563 14.54791259765625 L 36.4642333984375 13.72958278656006 C 36.65777206420898 13.53610134124756 36.76652908325195 13.27366638183594 36.7665901184082 13 L 34.27548217773438 13 L 34.18673706054688 13.08874797821045 L 34.09799194335938 13 L 31.60688591003418 13 C 31.60688591003418 13.27344608306885 31.71558952331543 13.53590488433838 31.90908622741699 13.7294282913208 L 32.72756958007813 14.54791259765625 L 29.54300308227539 17.73248291015625 L 26.35843086242676 14.54791259765625 L 27.17675971984863 13.72958278656006 C 27.37030220031738 13.53610229492188 27.47906303405762 13.27366733551025 27.47912216186523 13 L 24.98801422119141 13 L 24.89926719665527 13.08874797821045 L 24.81052017211914 13 L 22.31941413879395 13 C 22.31941413879395 13.27344608306885 22.4281177520752 13.53590488433838 22.62161636352539 13.7294282913208 L 23.44009971618652 14.54791259765625 L 20.25553131103516 17.73248291015625 L 17.00697898864746 14.48393249511719 C 16.41666793823242 14.84057903289795 15.8635425567627 15.2554235458374 15.35587406158447 15.72226238250732 C 15.37754344940186 15.74702930450439 15.38579940795898 15.77798748016357 15.40953350067139 15.80172061920166 L 18.79636573791504 19.19164657592773 L 15.61179542541504 22.37621879577637 L 13.10417747497559 19.86860084533691 C 12.98790645599365 19.75644683837891 12.84631633758545 19.67396926879883 12.69140148162842 19.62815856933594 C 12.42289161682129 20.33100700378418 12.23221874237061 21.06116485595703 12.12279891967773 21.80555534362793 L 14.15263080596924 23.83538246154785 L 12 25.98801231384277 L 12 28.47911834716797 C 12.27344703674316 28.47911834716797 12.53590488433838 28.37041473388672 12.7294282913208 28.17691612243652 L 15.61179542541504 25.29454803466797 L 18.79636573791504 28.47911834716797 L 14.47665882110596 32.79779434204102 C 14.37381172180176 32.90217971801758 14.29462432861328 33.02747344970703 14.24447154998779 33.16516494750977 C 14.82492733001709 33.47243118286133 15.47101593017578 33.63492584228516 16.12776756286621 33.63882446289063 L 16.55498886108398 33.63882446289063 L 20.25553131103516 29.93828392028809 L 23.48344421386719 33.16619491577148 C 23.40984344482422 33.31281280517578 23.37200546264648 33.47477340698242 23.37302398681641 33.63882446289063 L 26.42550849914551 33.63882446289063 C 26.42652320861816 33.47477340698242 26.38868522644043 33.31281280517578 26.31508827209473 33.16619491577148 L 29.54300308227539 29.93828392028809 L 32.77091217041016 33.16619491577148 C 32.69731903076172 33.31281661987305 32.65948104858398 33.47477340698242 32.66049575805664 33.63882446289063 L 35.71297836303711 33.63882446289063 C 35.71399688720703 33.47477340698242 35.6761589050293 33.31281280517578 35.60256195068359 33.16619110107422 L 38.83047103881836 29.93828392028809 L 42.05838394165039 33.16619491577148 C 41.98478698730469 33.31281280517578 41.94694900512695 33.47477340698242 41.94796371459961 33.63882446289063 L 45.00045013427734 33.63882446289063 C 45.00146865844727 33.47477722167969 44.96363067626953 33.31281661987305 44.89003372192383 33.16619491577148 L 48.11794281005859 29.93828392028809 L 51.23440551757813 33.05474472045898 C 51.83674240112305 32.70006561279297 52.33889389038086 32.19791412353516 52.69357299804688 31.5955810546875 L 49.57711029052734 28.47911834716797 L 52.80501937866211 25.25120544433594 C 52.94948959350586 25.33298110961914 53.11171340942383 25.37831878662109 53.27764892578125 25.3832950592041 L 53.27764892578125 23.31941223144531 C 53.27764892578125 22.97887229919434 53.25907516479492 22.64245796203613 53.22708511352539 22.31017303466797 Z M 43.47420883178711 16.00707626342773 L 46.65877914428711 19.19164657592773 L 43.47420883178711 22.37621879577637 L 40.28963851928711 19.19164657592773 L 43.47420883178711 16.00707626342773 Z M 34.18673706054688 16.00707626342773 L 37.37130737304688 19.19164657592773 L 34.18673706054688 22.37621879577637 L 31.00216674804688 19.19164657592773 L 34.18673706054688 16.00707626342773 Z M 24.89926719665527 16.00707626342773 L 28.08383750915527 19.19164657592773 L 24.89926719665527 22.37621879577637 L 21.71469497680664 19.19164657592773 L 24.89926719665527 16.00707626342773 Z M 17.07095909118652 23.83538246154785 L 20.25553131103516 20.65081214904785 L 23.44010162353516 23.83538246154785 L 20.25553131103516 27.01995468139648 L 17.07095909118652 23.83538246154785 Z M 24.89926719665527 31.66368865966797 L 21.71469497680664 28.47911834716797 L 24.89926719665527 25.29454803466797 L 28.08383750915527 28.47911834716797 L 24.89926719665527 31.66368865966797 Z M 26.35843086242676 23.83538246154785 L 29.54300308227539 20.65081214904785 L 32.72756958007813 23.83538246154785 L 29.54300308227539 27.01995468139648 L 26.35843086242676 23.83538246154785 Z M 34.18673706054688 31.66368865966797 L 31.00216674804688 28.47911834716797 L 34.18673706054688 25.29454803466797 L 37.37130737304688 28.47911834716797 L 34.18673706054688 31.66368865966797 Z M 35.64590454101563 23.83538246154785 L 38.83047103881836 20.65081214904785 L 42.01504135131836 23.83538246154785 L 38.83047103881836 27.01995468139648 L 35.64590454101563 23.83538246154785 Z M 43.47420883178711 31.66368865966797 L 40.28963851928711 28.47911834716797 L 43.47420883178711 25.29454803466797 L 46.65877914428711 28.47911834716797 L 43.47420883178711 31.66368865966797 Z M 48.11794281005859 27.01995468139648 L 44.93337631225586 23.83538246154785 L 48.11794281005859 20.65081214904785 L 51.30251312255859 23.83538246154785 L 48.11794281005859 27.01995468139648 Z" fill="#e59730" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-11.43, -3.0)" d="M 37.22359085083008 3 L 31.03194236755371 3 L 31.0123348236084 3.103194236755371 C 30.33902359008789 6.466903209686279 29.99993324279785 9.888956069946289 30 13.31940650939941 L 34.12776565551758 13.31941223144531 C 34.12776947021484 9.942562103271484 35.04533004760742 6.62999153137207 36.7823371887207 3.735081672668457 L 37.22359085083008 3 Z" fill="#fcbc04" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-11.87, -2.11)" d="M 35.06821441650391 58.96560668945313 L 28.02211570739746 53.24452590942383 C 26.00514221191406 51.60686874389648 24.35453987121582 49.56391525268555 23.17715835571289 47.2479133605957 C 22.24043655395508 45.40576934814453 22.28335571289063 43.21796035766602 23.29160118103027 41.41396713256836 C 24.29984664916992 39.60997772216797 26.14080238342285 38.42708206176758 28.20063972473145 38.25970077514648 L 49.02212142944336 36.57248306274414 L 49.02212142944336 31.00000190734863 L 16 31.00000190734863 L 16 40.89218521118164 C 16 46.48512268066406 18.52065658569336 51.78084564208984 22.86193656921387 55.30802536010742 L 29.90850448608398 61.02948760986328 C 31.42510604858398 62.26183319091797 33.59805297851563 62.26183319091797 35.11465454101563 61.02948760986328 L 36.68320465087891 59.75607299804688 C 36.093017578125 59.61532974243164 35.54142761230469 59.3453483581543 35.06821823120117 58.96560668945313 Z" fill="#fcbc04" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-12.0, -2.65)" d="M 29.54300308227539 28.45235252380371 C 23.27382469177246 28.45235252380371 18.19165229797363 23.37018013000488 18.191650390625 17.10099983215332 L 18.19164848327637 13.83800029754639 C 14.43206024169922 15.47881603240967 12.00129127502441 19.19059753417969 11.99999809265137 23.29264450073242 L 12 29.48429489135742 C 12 31.76399421691895 13.84806442260742 33.61205673217773 16.12776374816895 33.61205673217773 L 49.14988327026367 33.61205673217773 C 51.42958831787109 33.61205673217773 53.27764892578125 31.76399421691895 53.27764892578125 29.48429489135742 L 53.27764892578125 28.45235252380371 L 29.54300308227539 28.45235252380371 Z" fill="#e59730" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-11.43, -3.0)" d="M 33.15774536132813 10.2855052947998 C 32.48815536499023 9.623991966247559 32.13584518432617 8.706179618835449 32.19081497192383 7.766536235809326 C 32.29400634765625 6.169092655181885 32.50039672851563 4.580934524536133 32.75115966796875 3.000000715255737 L 31.03194236755371 3.000000715255737 L 31.0123348236084 3.103194713592529 C 30.33902359008789 6.466903209686279 29.99993324279785 9.888956069946289 30 13.31940650939941 L 34.12776565551758 13.31941223144531 C 34.12961578369141 12.54965591430664 34.17924118041992 11.78075790405273 34.2763671875 11.01715087890625 C 33.85751724243164 10.85207176208496 33.47684478759766 10.60309028625488 33.15774536132813 10.28550434112549 Z" fill="#e59730" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></g></g><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#ffffffff"  /><stop offset="1.0" stop-color="#00ffffff" stop-opacity="0.0" /></linearGradient></defs><path transform="translate(-117.0, 189.0)" d="M 314 0 L 628 511 L 0 511 Z" fill="url(#gradient)" fill-opacity="0.19" stroke="none" stroke-width="1" stroke-opacity="0.19" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
