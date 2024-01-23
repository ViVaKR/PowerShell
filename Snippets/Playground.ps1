. "./PI.ps1"

<# 
    ! MAC (Medium Access Control) Address **
    - 네트워크 인터페이스 카드에 각인된 물리적 주소
    - 6 바이트 (48bits, 6 octets), octets (==byte) 8개
    - 첫 3바이트 : IEEE 에서 기업이나 단체에 할당
    - 뒤 3바이트 : 차례대로 기업이나 단체에서 할당
    - 약 280조 개 할당 가능 (256 * 256 * 256 * 256 * 256 * 256)

    - From (mac address) -> To (mac address)
#>

<# 
    ! 프레임 (Frame) - | 목적지 맥주소 | 소스 맥주소 | 데이터 |
    - IEEE 802.3 Ethernet Frame Format
    - www.geeksforgeeks.org/ethernet-frame-format
    * | Preamble | SFD | Destinamtion | Source | Length |    Data    | CRC | *
    *     7         1         6           6        2      46 ~ 1500     4   
#>

<# 
    ! Switch (스위치)
    - MAC 주소들을 저장하고 있음 (공유기 내부에 포함되어 있음)
    - 충돌이 일어나지 않음
#>

<# 
    ! WAN (Wide Area Network)
    - LAN + LAN : 로컬네트워크 상호간 연결 방식
    - Router + Router : WAN, 인터넷 방식
        -> Router (라우터) 간의 통신은 맥 주소를 사용하지 않고, 아이피 주소(IP Address) 를 사용함.
        -> IP Address 아이피 주소는 직접 또는 자동 할당함
#>

<# 
    ! Packet (패킷) - | 소스 아이피 주소 | 목적지 아이피 주소 | 데이터 |
    - 라우터에서 프레임으로는 부족하므로 패킷을 사용함
#>

<# 
    ! Rounter (라우터, 가정에서는 공유기, 게이트웨이)
    - 처음 라우터 연결시 라우터의 맥주소는 모르지만 라우터의 아이피 주소는 로컬 컴퓨터는 인식하고 있음.
    - 아이피는 알지만, 프레임을 보내려면 라우터의 맥 주소를 알아야 함
    - 아이피 주소를 통해 맥주소를 알수 있음
        -> ARP (Address REsolution Protocol)
    - ㄴ어라ㅣ
#>
